python render.py  --config ./configs/volsdf_fangzhou_vangogh.yaml --load_pt ./pretrained/volsdf_fangzhou_vangogh.pt --downscale 2 --H 480 --W 270 --exp_name volsdf_fangzhou_vangogh  --num_views 90  --save_images 

python render.py  --config ./configs/volsdf_fangzhou_vangogh.yaml --load_pt ./pretrained/volsdf_fangzhou_edvard.pt --downscale 2 --H 480 --W 270 --exp_name volsdf_fangzhou_edvard  --num_views 90  --save_images 

python render.py  --config ./configs/volsdf_fangzhou_nature.yaml --load_pt ./pretrained/volsdf_fangzhou_nature_source.pt --downscale 2 --H 480 --W 270 --exp_name volsdf_fangzhou_source  --num_views 90  --save_images 