scene=fortress
fg=/home/tth/dev/prj-nerf/ARF-svox2/opt/ckpt_arf/llff/fortress_1/fortress_1.mp4
bg=/home/tth/dev/prj-nerf/all_masked_videos/fortress_3.mp4
python3 merge_two_videos.py \
  --foreground_video $fg \
  --background_video $bg \
  --output ${scene}.tmp.mp4 \
  --masks_dir /home/tth/dev/prj-nerf/Track-Anything/result/mask/fortress0

# from mp4v to x264
ffmpeg -i ${scene}.tmp.mp4 -vcodec libx264 ${scene}.mp4

# Get the resolution of video A
resolution=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=p=0 $fg)

# Extract the width and height values
width=$(echo $resolution | cut -d ',' -f 1)
height=$(echo $resolution | cut -d ',' -f 2)
echo $width
echo $height
# Calculate the output width and height
output_width=$(expr $width \* 4)
output_height=$height

# Use the calculated dimensions in the ffmpeg command
ffmpeg -i /home/tth/dev/prj-nerf/ARF-svox2/opt/ckpt_svox2/llff/fortress/fortress.mp4 -i /home/tth/dev/prj-nerf/ARF-svox2/opt/ckpt_arf/llff/fortress_3/fortress_3.mp4 -i $fg -i ${scene}.mp4 -filter_complex "[0:v]scale=$width:$height[p0]; [1:v]scale=$width:$height[p1]; [2:v]scale=$width:$height[p2]; [3:v]scale=$width:$height[p3]; [p0][p1][p2][p3]hstack=4,scale=$output_width:$output_height" ${scene}_merged.mp4
