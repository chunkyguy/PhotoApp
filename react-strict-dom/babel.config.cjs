// One Babel config for three callers:
//  - Metro (Expo, iOS/Android): babel-preset-expo + RSD preset for native
//  - @vitejs/plugin-react (web): RSD preset compiles `css.create` to class names
//  - RSD PostCSS plugin (web): same preset, used to extract the CSS
module.exports = function (api) {
  const caller = {
    name: api.caller((c) => c?.name),
    platform: api.caller((c) => c?.platform),
    isDev: api.caller((c) => c?.isDev),
  };
  api.cache.using(() => `${caller.name}:${caller.platform}:${process.env.NODE_ENV}`);

  if (caller.name === "metro") {
    const dev = caller.isDev ?? process.env.NODE_ENV !== "production";
    return {
      presets: [
        "babel-preset-expo",
        ["react-strict-dom/babel-preset", { debug: dev, dev, platform: caller.platform }],
      ],
    };
  }

  const dev = process.env.NODE_ENV !== "production";
  return {
    // The PostCSS plugin parses .jsx files with this config, so it must understand JSX.
    // The JSX transform itself is done by @vitejs/plugin-react.
    parserOpts: { plugins: ["jsx"] },
    presets: [["react-strict-dom/babel-preset", { debug: dev, dev, platform: "web" }]],
  };
};
