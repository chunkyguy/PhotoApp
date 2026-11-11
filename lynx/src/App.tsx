import { useEffect, useState } from "@lynx-js/react";

import "./App.css";
import { fetchPhotos, photoUrl, type Photo } from "./api.js";
import { Details } from "./Details.js";
import { useSafeArea } from "./safeArea.js";

export function App() {
  const [photos, setPhotos] = useState<Photo[] | null>(null);
  const [error, setError] = useState<string | null>(null);
  // Bumping this re-runs the fetch effect.
  const [attempt, setAttempt] = useState(0);
  const [selected, setSelected] = useState<Photo | null>(null);
  const insets = useSafeArea();

  // useEffect runs on the background thread, where fetch is available.
  useEffect(() => {
    let cancelled = false;
    fetchPhotos()
      .then((result) => {
        if (!cancelled) setPhotos(result);
      })
      .catch((e: unknown) => {
        console.error("[App] failed to load photos", e);
        if (!cancelled) setError(e instanceof Error ? e.message : String(e));
      });
    return () => {
      cancelled = true;
    };
  }, [attempt]);

  const retry = () => {
    setError(null);
    setPhotos(null);
    setAttempt((n) => n + 1);
  };

  if (error != null) {
    return (
      <view className="Center">
        <text className="ErrorTitle">Couldn't load photos</text>
        <text className="Message">{error}</text>
        <view className="Button" bindtap={retry}>
          <text className="ButtonText">Retry</text>
        </view>
      </view>
    );
  }

  if (photos == null) {
    return (
      <view className="Center">
        <view className="Spinner" />
        <text className="Message">Loading photos…</text>
      </view>
    );
  }

  // Keep the grid mounted under the details view so its scroll position survives.
  return (
    <view
      className="Screen"
      style={{
        paddingTop: `${insets.top}px`,
        paddingLeft: `${insets.left}px`,
        paddingRight: `${insets.right}px`,
      }}
    >
      <list
        className="Grid"
        style={{ paddingBottom: `${insets.bottom}px` }}
        list-type="flow"
        span-count={2}
      >
        {photos.map((photo) => (
          <list-item
            item-key={`photo-${photo.id}`}
            key={`photo-${photo.id}`}
            className="Cell"
            bindtap={() => setSelected(photo)}
          >
            <image
              className="Photo"
              src={photoUrl(photo.id, 400)}
              mode="aspectFill"
            />
          </list-item>
        ))}
      </list>
      {selected != null && (
        <Details photo={selected} onBack={() => setSelected(null)} />
      )}
    </view>
  );
}
