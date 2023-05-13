import cv2
import matplotlib.pyplot as plt

# Read four images
img1 = cv2.imread('/home/tth/dev/prj-nerf/NeRF-Art/data/fangzhou_nature/images/000001.png', cv2.IMREAD_COLOR)
img2 = cv2.imread('/home/tth/Downloads/demo/volsdf_fangzhou_source/00001.png', cv2.IMREAD_COLOR)
img3 = cv2.imread('/home/tth/Downloads/demo/volsdf_fangzhou_vangogh/00001.png', cv2.IMREAD_COLOR)
img4 = cv2.imread('/home/tth/Downloads/demo/output_sty_van_face/output_00001.png', cv2.IMREAD_COLOR)
img5 = cv2.imread('/home/tth/Downloads/demo/output_sty_van_faceb/output_00001.png', cv2.IMREAD_COLOR)

# Convert the images from BGR to RGB (as Matplotlib uses RGB)
img1 = cv2.cvtColor(img1, cv2.COLOR_BGR2RGB)
img2 = cv2.cvtColor(img2, cv2.COLOR_BGR2RGB)
img3 = cv2.cvtColor(img3, cv2.COLOR_BGR2RGB)
img4 = cv2.cvtColor(img4, cv2.COLOR_BGR2RGB)
img5 = cv2.cvtColor(img5, cv2.COLOR_BGR2RGB)

# Create a 2x2 grid of subplots and display the images with titles
fig, axes = plt.subplots(1, 5, figsize=(10, 5))
axes = axes.flatten()

axes[0].imshow(img1)
axes[0].set_title('Real Image')
axes[0].axis('off')

axes[1].imshow(img2)
axes[1].set_title('NeRF')
axes[1].axis('off')

axes[2].imshow(img3)
axes[2].set_title('Full stylization')
axes[2].axis('off')

axes[3].imshow(img4)
axes[3].set_title('Object stylization\n(Ours, Object=face)')
axes[3].axis('off')

axes[4].imshow(img5)
axes[4].set_title('Background stylization\n(Ours, Object=face)')
axes[4].axis('off')

plt.tight_layout()
plt.show()
fig.savefig('figure_van_face.png')

if __name__ == '__main__':
    pass