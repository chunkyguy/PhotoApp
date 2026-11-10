import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

// React Strict DOM compiles `css.create` at build time via its Babel preset
// (see babel.config.cjs) and emits the CSS through its PostCSS plugin.
//
// RSD's own web build also calls `stylex.create`, so it must go through Babel
// as well. Vite skips Babel for node_modules and pre-bundles deps with esbuild,
// so we opt react-strict-dom out of both.
export default defineConfig({
  plugins: [
    react({
      babel: { configFile: true },
      exclude: /\/node_modules\/(?!react-strict-dom\/)/,
    }),
  ],
  optimizeDeps: {
    exclude: ["react-strict-dom"],
    include: ["react-strict-dom > @stylexjs/stylex"],
  },
});
