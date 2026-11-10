// Native entry point (Expo / Metro). The web entry is index.html -> src/main.jsx.
import { registerRootComponent } from "expo";
import { StatusBar } from "expo-status-bar";
import { SafeAreaProvider, SafeAreaView } from "react-native-safe-area-context";
import { css, html } from "react-strict-dom";
import { App } from "./src/App";

function Root() {
  return (
    <SafeAreaProvider>
      <SafeAreaView style={{ flex: 1, backgroundColor: "#fff" }} edges={["top", "left", "right"]}>
        <StatusBar style="dark" />
        {/* Same role as #root in index.css on web: a full-height flex column.
            RSD only knows a parent is flex if it's an RSD element. */}
        <html.div style={styles.root}>
          <App />
        </html.div>
      </SafeAreaView>
    </SafeAreaProvider>
  );
}

const styles = css.create({
  root: {
    display: "flex",
    flexDirection: "column",
    height: "100%",
  },
});

registerRootComponent(Root);
