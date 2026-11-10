import { css, html } from "react-strict-dom";

// Web: a scrollable div that fills the remaining height.
// Native uses ScrollView.native.jsx, since RSD has no scroll container on native.
export function ScrollView({ children }) {
  return <html.div style={styles.scroll}>{children}</html.div>;
}

const styles = css.create({
  scroll: {
    flexGrow: 1,
    flexShrink: 1,
    flexBasis: 0,
    minHeight: 0,
    overflowY: "auto",
  },
});
