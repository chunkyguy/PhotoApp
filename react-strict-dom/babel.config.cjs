const dev = process.env.NODE_ENV !== "production";

module.exports = {
  // The RSD PostCSS plugin parses .jsx files with this config, so it must understand JSX.
  // The JSX transform itself is done by @vitejs/plugin-react.
  parserOpts: { plugins: ["jsx"] },
  presets: [["react-strict-dom/babel-preset", { debug: dev, dev }]],
};
