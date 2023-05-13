import os
import cv2
import numpy as np

# Set your folder paths here
image1_folder = "/home/tth/dev/prj-nerf/NeRF-Art/out/volsdf_fangzhou_source/rgb"
image2_folder = "/home/tth/dev/prj-nerf/NeRF-Art/out/volsdf_fangzhou_vangogh/rgb"
mask_folder = "/home/tth/dev/prj-nerf/segment-anything/notebooks/masks"
output_folder = "/home/tth/dev/prj-nerf/segment-anything/notebooks/output_sty_van_faceb"

if not os.path.exists(output_folder):
    os.makedirs(output_folder)

# Process all image pairs and masks
for img_name in os.listdir(image1_folder):
    # Check if corresponding mask file exists
    if os.path.isfile(os.path.join(mask_folder, f'{img_name}_m2.png')):
        # Read image pair and mask
        img1 = cv2.imread(os.path.join(image1_folder, img_name), cv2.IMREAD_COLOR)
        img2 = cv2.imread(os.path.join(image2_folder, img_name), cv2.IMREAD_COLOR)
        mask = cv2.imread(os.path.join(mask_folder, f'{img_name}_m2.png'), cv2.IMREAD_GRAYSCALE)

        # Threshold the mask image
        _, mask = cv2.threshold(mask, 128, 255, cv2.THRESH_BINARY)

        # Invert the mask to apply it on the second image
        mask_inv = cv2.bitwise_not(mask)

        # Combine image pair using the masks
        img1_masked = cv2.bitwise_and(img1, img1, mask=mask)
        img2_masked = cv2.bitwise_and(img2, img2, mask=mask_inv)
        output = cv2.add(img1_masked, img2_masked)

        # Save the output image
        cv2.imwrite(os.path.join(output_folder, f"output_{img_name}"), output)
        print(f"Processed and saved output image: output_{img_name}")
    else:
        print(f"Mask not found for image: {img_name}")

print("Processing complete!")


if __name__ == '__main__':
    pass