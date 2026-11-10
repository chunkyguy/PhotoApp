import { useEffect, useState } from "react";
import { css, html } from "react-strict-dom";
import { fetchPhoto, photoUrl } from "../api.js";
import { Loading } from "../components/Loading.jsx";

export function Details({ id, onBack }) {
  const [photo, setPhoto] = useState(null);
  const [error, setError] = useState(null);

  useEffect(() => {
    let cancelled = false;
    fetchPhoto(id)
      .then((info) => !cancelled && setPhoto(info))
      .catch((e) => !cancelled && setError(e.message));
    return () => {
      cancelled = true;
    };
  }, [id]);

  return (
    <html.div style={styles.screen}>
      <html.button style={styles.back} onClick={onBack}>
        ‹ Back
      </html.button>
      {error ? (
        <Loading message={error} />
      ) : !photo ? (
        <Loading />
      ) : (
        <html.div style={styles.content}>
          <html.img
            src={photoUrl(photo.id, 800, Math.round((800 * photo.height) / photo.width))}
            alt={`Photo by ${photo.author}`}
            style={[styles.image, styles.aspectRatio(photo.width / photo.height)]}
          />
          <html.h1 style={styles.author}>{photo.author}</html.h1>
          <Row label="ID" value={photo.id} />
          <Row label="Size" value={`${photo.width} × ${photo.height}`} />
          <html.a href={photo.url} target="_blank" style={styles.link}>
            View on Unsplash
          </html.a>
        </html.div>
      )}
    </html.div>
  );
}

function Row({ label, value }) {
  return (
    <html.div style={styles.row}>
      <html.span style={styles.label}>{label}</html.span>
      <html.span>{value}</html.span>
    </html.div>
  );
}

const styles = css.create({
  screen: {
    padding: 16,
  },
  back: {
    alignSelf: "flex-start",
    borderWidth: 0,
    backgroundColor: "transparent",
    color: "#2563eb",
    fontSize: 16,
    padding: 0,
    marginBottom: 12,
    cursor: "pointer",
  },
  content: {
    gap: 8,
  },
  image: {
    width: "100%",
    borderRadius: 8,
  },
  aspectRatio: (ratio) => ({
    aspectRatio: ratio,
  }),
  author: {
    fontSize: 22,
    fontWeight: "bold",
    marginTop: 8,
    marginBottom: 0,
  },
  row: {
    display: "flex",
    flexDirection: "row",
    gap: 8,
  },
  label: {
    color: "#71717a",
    width: 48,
  },
  link: {
    color: "#2563eb",
  },
});
