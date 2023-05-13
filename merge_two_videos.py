import cv2
import numpy as np
import argparse
import os

def merge_two_videos(args):
    # Load the videos
    fg = cv2.VideoCapture(args.foreground_video)
    bg = cv2.VideoCapture(args.background_video)

    # Get the video properties (we assume that both videos have the same properties)
    fps = fg.get(cv2.CAP_PROP_FPS)
    width = int(fg.get(cv2.CAP_PROP_FRAME_WIDTH))
    height = int(fg.get(cv2.CAP_PROP_FRAME_HEIGHT))

    # Create a VideoWriter for the output video
    fourcc = cv2.VideoWriter_fourcc(*'mp4v')  # or use 'XVID'
    out = cv2.VideoWriter(args.output, fourcc, fps, (width, height))

    frame_num = 0
    while fg.isOpened() and bg.isOpened():
        ret_fg, frame_fg = fg.read()
        ret_bg, frame_bg = bg.read()

        if ret_fg is True and ret_bg is True:
            # Load the mask for the current frame
            mask_path = os.path.join(args.masks_dir, f'{str(frame_num).zfill(5)}.npy')
            mask = np.load(mask_path)

            # Merge the foreground and background frames
            fg_frame = cv2.bitwise_and(frame_fg, frame_fg, mask=mask)
            bg_frame = cv2.bitwise_and(frame_bg, frame_bg, mask=1-mask)
            merged_frame = cv2.add(fg_frame, bg_frame)

            # Write the merged frame to the output video
            out.write(merged_frame)

            frame_num += 1
        else:
            break

    # Release everything
    fg.release()
    bg.release()
    out.release()
    cv2.destroyAllWindows()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Merge two videos with masks.')
    parser.add_argument('--foreground_video', type=str, required=True, help='Foreground video file.')
    parser.add_argument('--background_video', type=str, required=True, help='Background video file.')
    parser.add_argument('--output', type=str, required=True, help='Output video file.')
    parser.add_argument('--masks_dir', type=str, required=True, help='Directory containing mask files.')
    args = parser.parse_args()

    merge_two_videos(args)
