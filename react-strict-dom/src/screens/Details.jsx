import { useEffect, useState } from "react";
import { css, html } from "react-strict-dom";
import { fetchPhoto, photoUrl } from "../api";
import { Loading } from "../components/Loading";
import { ScrollView } from "../components/ScrollView";
import { openUrl } from "../platform/openUrl";

export function Details({ id, onBack }) {
  const [photo, setPhoto] = useState(null);
  const [error, setError] = useState(null);
  const [attempt, setAttempt] = useState(0);

  useEffect(() => {
    let cancelled = false;
    setError(null);
    fetchPhoto(id)
      .then((info) => !cancelled && setPhoto(info))
      .catch((e) => !cancelled && setError(e.message));
    return () => {
      cancelled = true;
    };
  }, [id, attempt]);

  return (
    <html.div style={styles.screen}>
      <html.header style={styles.header}>
        <html.button style={styles.back} onClick={onBack}>
          <html.span style={styles.backText}>‹ Back</html.span>
        </html.button>
      </html.header>
      {error ? (
        <Loading message={error} onRetry={() => setAttempt((n) => n + 1)} />
      ) : !photo ? (
        <Loading />
      ) : (
        <ScrollView>
          <html.div style={styles.content}>
            <html.img
              src={photoUrl(photo.id, 800, Math.round((800 * photo.height) / photo.width))}
              alt={`Photo by ${photo.author}`}
              style={[styles.image, styles.aspectRatio(photo.width / photo.height)]}
            />
            <html.h1 style={styles.author}>{photo.author}</html.h1>
            <Row label="ID" value={photo.id} />
            <Row label="Size" value={`${photo.width} × ${photo.height}`} />
            <html.button style={styles.linkButton} onClick={() => openUrl(photo.url)}>
              <html.span style={styles.link}>View on Unsplash</html.span>
            </html.button>
          </html.div>
        </ScrollView>
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
    flexGrow: 1,
    flexShrink: 1,
    flexBasis: 0,
    minHeight: 0,
    display: "flex",
    flexDirection: "column",
    backgroundColor: "#fff",
  },
  header: {
    borderBottomWidth: 1,
    borderBottomStyle: "solid",
    borderBottomColor: "#dbdbdb",
    paddingBlock: 12,
    paddingInline: 16,
    display: "flex",
    alignItems: "flex-start",
  },
  back: {
    borderWidth: 0,
    backgroundColor: "transparent",
    padding: 0,
    cursor: "pointer",
  },
  backText: {
    color: "#2563eb",
    fontSize: 16,
  },
  content: {
    boxSizing: "border-box",
    display: "flex",
    flexDirection: "column",
    gap: 8,
    padding: 16,
    maxWidth: 935,
    width: "100%",
    marginInline: "auto",
  },
  image: {
    width: "100%",
    borderRadius: 8,
    backgroundColor: "#efefef",
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
  linkButton: {
    alignSelf: "flex-start",
    borderWidth: 0,
    backgroundColor: "transparent",
    padding: 0,
    marginTop: 8,
    cursor: "pointer",
  },
  link: {
    color: "#2563eb",
    fontSize: 16,
  },
});
