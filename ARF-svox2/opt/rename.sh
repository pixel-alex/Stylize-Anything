for type in $(ls ckpt_arf); do
  for scene in $(ls ckpt_arf/$type); do
    if [[ -f "ckpt_arf/$type/$scene/test_renders_path.mp4" ]]; then
      cp "ckpt_arf/$type/$scene/test_renders_path.mp4" "ckpt_arf/$type/$scene/$scene.mp4"
    fi
    if [[ -f "ckpt_arf/$type/$scene/circle_renders.mp4" ]]; then
      cp "ckpt_arf/$type/$scene/circle_renders.mp4" "ckpt_arf/$type/$scene/$scene.mp4"
    fi
  done
done

for type in $(ls ckpt_svox2); do
  for scene in $(ls ckpt_svox2/$type); do
    if [[ -f "ckpt_svox2/$type/$scene/test_renders_path.mp4" ]]; then
      cp "ckpt_svox2/$type/$scene/test_renders_path.mp4" "ckpt_svox2/$type/$scene/$scene.mp4"
    fi
    if [[ -f "ckpt_svox2/$type/$scene/circle_renders.mp4" ]]; then
      cp "ckpt_svox2/$type/$scene/circle_renders.mp4" "ckpt_svox2/$type/$scene/$scene.mp4"
    fi
  done
done