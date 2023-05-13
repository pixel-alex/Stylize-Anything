#!/bin/bash

# get the GPU usage using nvidia-smi
gpu_usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)

# convert the usage to an array
#echo "gpu_usage: $gpu_usage"
#read -a gpu_usage_array <<< $gpu_usage
gpu_usage_array=( $(echo "$gpu_usage") )

# loop through the GPUs to find the first idle one
for i in "${!gpu_usage_array[@]}"; do
#    echo $i
    if [ "${gpu_usage_array[$i]}" -lt 5 ]; then
        echo "GPU $i is idle (" "${gpu_usage_array[$i]}" "%)"
        exit 0
    fi
done

# if no idle GPU was found
echo "No idle GPU found"
exit 1
