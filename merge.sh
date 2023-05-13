outdir=all_masked_videos
mkdir -p ${outdir}
ARF=/home/tth/dev/prj-nerf/ARF-svox2/opt/ckpt_arf
SVOX2=/home/tth/dev/prj-nerf/ARF-svox2/opt/ckpt_svox2
for type in $(ls $ARF); do
  for scene in $(ls $ARF/$type); do
    # foregroud exists
    fg="$ARF/$type/$scene/$scene.mp4"
    if [[ -f $fg ]]; then

      scene_bg=$(echo $scene | cut -f1 -d "_")
      bg="$SVOX2/$type/$scene_bg/${scene_bg}.mp4"
      # background exists
      if [[ -f $bg ]]; then
        echo "${outdir}/${scene}.mp4"
        (
          python3 merge_two_videos.py \
            --foreground_video $fg \
            --background_video $bg \
            --output ${outdir}/${scene}.tmp.mp4 \
            --masks_dir /home/tth/dev/prj-nerf/Track-Anything/result/mask/${scene_bg}

          # from mp4v to x264
          ffmpeg -i ${outdir}/${scene}.tmp.mp4 -vcodec libx264 ${outdir}/${scene}.mp4
          rm ${outdir}/${scene}.tmp.mp4

          # Get the resolution of video A
          resolution=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=p=0 $fg)

          # Extract the width and height values
          width=$(echo $resolution | cut -d ',' -f 1)
          height=$(echo $resolution | cut -d ',' -f 2)
          echo $width
          echo $height
          # Calculate the output width and height
          output_width=$(expr $width \* 3)
          output_height=$height

          # Use the calculated dimensions in the ffmpeg command
          ffmpeg -i $bg -i $fg -i ${outdir}/${scene}.mp4 -filter_complex "[0:v]scale=$width:$height[p0]; [1:v]scale=$width:$height[p1]; [2:v]scale=$width:$height[p2]; [p0][p1][p2]hstack=3,scale=$output_width:$output_height" ${outdir}/${scene}_merged.mp4
        ) &
      fi
    fi
    sleep 1
  done
done
