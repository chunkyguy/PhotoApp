const { rules } = require("eslint-config-prettier");

module.exports = {
  root: true,
  extends: ['@react-native-community', 'airbnb-typescript', 'prettier', 'prettier/@typescript-eslint', 'prettier/react'],
};

rules = {
  // suppress warning: 'React' must be in scope when using JSX
  "react/react-in-jsx-scope": "off",
}