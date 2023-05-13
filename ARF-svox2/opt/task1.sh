all_styles=(1 2 3 14 19 34 73 128 131 133)
used_styles=(1 2 3 14 19 34 73 128 131 133)

export CUDA_VISIBLE_DEVICES=1

for style in "${used_styles[@]}"; do

  # llff
  for scene in $(ls ../data/llff/); do
    echo $scene $style
    ./try_llff.sh $scene $style
  done

  # tnt
#  for scene in $(ls ../data/tnt/); do
#    echo $scene $style
#    ./try_tnt.sh $scene $style
#  done

  # custom
#  for scene in $(ls ../data/custom/); do
#    echo $scene $style
#    ./try_custom.sh $scene $style
#  done

done
