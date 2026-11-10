import { css, html } from "react-strict-dom";

export function Loading({ message = "Loading ..." }) {
  return (
    <html.div style={styles.container}>
      <html.p style={styles.text}>{message}</html.p>
    </html.div>
  );
}

const styles = css.create({
  container: {
    alignItems: "center",
    justifyContent: "center",
    padding: 32,
  },
  text: {
    color: "#52525b",
    fontSize: 16,
  },
});
