SCENE=$1
STYLE=$2

data_type=tnt
ckpt_svox2=ckpt_svox2/${data_type}/${SCENE}
ckpt_arf=ckpt_arf/${data_type}/${SCENE}_${STYLE}
data_dir=../data/${data_type}/${SCENE}
style_img=../data/styles/${STYLE}.jpg

# train base
if [[ ! -f "${ckpt_svox2}/ckpt.npz" ]]; then
    python opt.py -t ${ckpt_svox2} ${data_dir} \
                -c configs/tnt.json
fi

# train art
if [[ ! -f "${ckpt_arf}/ckpt.npz" ]]; then
python opt_style.py -t ${ckpt_arf} ${data_dir} \
                -c configs/tnt_fixgeom.json  \
                --init_ckpt ${ckpt_svox2}/ckpt.npz \
                --style ${style_img} \
                --mse_num_epoches 1 --nnfm_num_epoches 10 \
                --content_weight 5e-3
fi

# render art
if [[ ! -f "${ckpt_arf}/test_renders_path.mp4" ]]; then
python render_imgs.py ${ckpt_arf}/ckpt.npz ${data_dir} \
                --render_path --no_imsave
fi

# render base
if [[ ! -f "${ckpt_svox2}/test_renders_path.mp4" ]]; then
  python render_imgs.py ${ckpt_svox2}/ckpt.npz ${data_dir} \
                      --render_path --no_imsave
fi