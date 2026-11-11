import { photoUrl, type Photo } from "./api.js";
import { useSafeArea } from "./safeArea.js";

interface Props {
  photo: Photo;
  onBack: () => void;
}

const IMAGE_WIDTH = 800;

export function Details({ photo, onBack }: Props) {
  const aspect = photo.height / photo.width;
  const insets = useSafeArea();

  return (
    <view
      className="Details"
      style={{
        paddingLeft: `${insets.left}px`,
        paddingRight: `${insets.right}px`,
      }}
    >
      <view className="Header" style={{ paddingTop: `${12 + insets.top}px` }}>
        <view className="BackButton" bindtap={onBack}>
          <text className="BackText">‹ Back</text>
        </view>
      </view>
      <scroll-view className="DetailsScroll" scroll-orientation="vertical">
        <image
          className="DetailsImage"
          // Height in vw keeps the photo's real proportions at full screen width.
          style={{ height: `${100 * aspect}vw` }}
          src={photoUrl(photo.id, IMAGE_WIDTH, Math.round(IMAGE_WIDTH * aspect))}
          mode="aspectFit"
        />
        <view
          className="Caption"
          style={{ paddingBottom: `${16 + insets.bottom}px` }}
        >
          <text className="CaptionTitle">Photo by {photo.author}</text>
          <text className="CaptionDetail">
            {`#${photo.id} · ${photo.width} × ${photo.height}`}
          </text>
        </view>
      </scroll-view>
    </view>
  );
}
