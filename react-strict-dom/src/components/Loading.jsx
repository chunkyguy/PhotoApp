import { css, html } from "react-strict-dom";

export function Loading({ message = "Loading ...", onRetry }) {
  return (
    <html.div style={styles.container}>
      <html.p style={styles.text}>{message}</html.p>
      {onRetry && (
        <html.button style={styles.retry} onClick={onRetry}>
          <html.span style={styles.retryText}>Retry</html.span>
        </html.button>
      )}
    </html.div>
  );
}

const styles = css.create({
  container: {
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
    justifyContent: "center",
    gap: 12,
    padding: 32,
  },
  text: {
    color: "#52525b",
    fontSize: 16,
    textAlign: "center",
  },
  retry: {
    borderWidth: 1,
    borderStyle: "solid",
    borderColor: "#dbdbdb",
    borderRadius: 8,
    backgroundColor: "#fff",
    paddingBlock: 8,
    paddingInline: 16,
    cursor: "pointer",
  },
  retryText: {
    color: "#2563eb",
    fontSize: 15,
    fontWeight: "600",
  },
});
