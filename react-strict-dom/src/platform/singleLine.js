import { css } from "react-strict-dom";

// Web: browsers don't truncate with plain `line-clamp` yet, so use the classic trio.
export const singleLine = css.create({
  text: {
    overflow: "hidden",
    whiteSpace: "nowrap",
    textOverflow: "ellipsis",
  },
});
