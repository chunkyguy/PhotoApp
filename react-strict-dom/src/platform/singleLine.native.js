import { css } from "react-strict-dom";

// Native: RSD maps lineClamp to <Text numberOfLines>.
export const singleLine = css.create({
  text: {
    lineClamp: 1,
  },
});
