import cv2
import matplotlib.pyplot as plt

# Read four images
img2 = cv2.imread('/home/tth/Downloads/demo/volsdf_fangzhou_source/00001.png', cv2.IMREAD_COLOR)
img3 = cv2.imread('/home/tth/Downloads/demo/volsdf_fangzhou_vangogh/00001.png', cv2.IMREAD_COLOR)
img4 = cv2.imread('/home/tth/Downloads/demo/output_sty_van_face/output_00001.png', cv2.IMREAD_COLOR)
img5 = cv2.imread('/home/tth/Downloads/demo/output_sty_van_faceb/output_00001.png', cv2.IMREAD_COLOR)

# Convert the images from BGR to RGB (as Matplotlib uses RGB)
img2 = cv2.cvtColor(img2, cv2.COLOR_BGR2RGB)
img3 = cv2.cvtColor(img3, cv2.COLOR_BGR2RGB)
img4 = cv2.cvtColor(img4, cv2.COLOR_BGR2RGB)
img5 = cv2.cvtColor(img5, cv2.COLOR_BGR2RGB)

# Create a 2x2 grid of subplots and display the images with titles
fig, axes = plt.subplots(3, 5, figsize=(25, 25))
axes = axes.flatten()

for idx in range(15):
    img = cv2.imread(f'/home/tth/dev/prj-nerf/segment-anything/notebooks/output_sty_van_foreground/output_{idx*6+1:05}.png', cv2.IMREAD_COLOR)
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

    axes[idx].imshow(img)
    axes[idx].axis('off')

plt.tight_layout()
plt.show()
fig.savefig('figure_view.png')

if __name__ == '__main__':
    pass