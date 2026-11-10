import { useEffect, useState } from "react";
import { css, html } from "react-strict-dom";
import { fetchPhotos, photoUrl } from "../api.js";
import { Loading } from "../components/Loading.jsx";

export function Home({ onSelect }) {
  const [photos, setPhotos] = useState(null);
  const [error, setError] = useState(null);

  useEffect(() => {
    let cancelled = false;
    fetchPhotos()
      .then((list) => !cancelled && setPhotos(list))
      .catch((e) => !cancelled && setError(e.message));
    return () => {
      cancelled = true;
    };
  }, []);

  return (
    <html.div style={styles.screen}>
      <html.header style={styles.header}>
        <html.h1 style={styles.logo}>Photos</html.h1>
      </html.header>
      {error ? (
        <Loading message={error} />
      ) : !photos ? (
        <Loading />
      ) : (
        <html.div style={styles.grid}>
          {photos.map((photo) => (
            <PhotoTile
              key={photo.id}
              photo={photo}
              onPress={() => onSelect(photo.id)}
            />
          ))}
        </html.div>
      )}
    </html.div>
  );
}

function PhotoTile({ photo, onPress }) {
  return (
    <html.button style={styles.tile} onClick={onPress}>
      <html.img
        src={photoUrl(photo.id, 200)}
        alt={`Photo by ${photo.author}`}
        loading="lazy"
        style={styles.image}
      />
      <html.span style={styles.author} numberOfLines={1}>
        {photo.author}
      </html.span>
      <html.span style={styles.caption} numberOfLines={1}>
        {photo.width} × {photo.height}
      </html.span>
    </html.button>
  );
}

const styles = css.create({
  screen: {
    backgroundColor: "#fff",
    minHeight: "100vh",
  },
  header: {
    position: "sticky",
    top: 0,
    zIndex: 1,
    backgroundColor: "#fff",
    borderBottomWidth: 1,
    borderBottomStyle: "solid",
    borderBottomColor: "#dbdbdb",
    paddingBlock: 12,
    paddingInline: 16,
  },
  logo: {
    fontSize: 22,
    fontWeight: "600",
    letterSpacing: -0.5,
    margin: 0,
    maxWidth: 935,
    marginInline: "auto",
  },
  grid: {
    boxSizing: "border-box",
    display: "flex",
    flexDirection: "row",
    flexWrap: "wrap",
    maxWidth: 935,
    width: "100%",
    marginInline: "auto",
    padding: 2,
  },
  tile: {
    boxSizing: "border-box",
    display: "flex",
    flexDirection: "column",
    alignItems: "stretch",
    // 3 columns on phones, more as the screen gets wider
    width: {
      default: "33.333%",
      "@media (min-width: 600px) and (max-width: 899px)": "25%",
      "@media (min-width: 900px)": "20%",
    },
    padding: 2,
    paddingBottom: 10,
    borderWidth: 0,
    backgroundColor: "transparent",
    textAlign: "start",
    cursor: "pointer",
    opacity: {
      default: 1,
      ":hover": 0.85,
    },
  },
  image: {
    width: "100%",
    aspectRatio: 1,
    objectFit: "cover",
    backgroundColor: "#efefef",
  },
  author: {
    marginTop: 6,
    paddingInline: 2,
    fontSize: 13,
    fontWeight: "600",
    color: "#262626",
    overflow: "hidden",
    whiteSpace: "nowrap",
    textOverflow: "ellipsis",
  },
  caption: {
    paddingInline: 2,
    fontSize: 12,
    color: "#8e8e8e",
    overflow: "hidden",
    whiteSpace: "nowrap",
    textOverflow: "ellipsis",
  },
});
