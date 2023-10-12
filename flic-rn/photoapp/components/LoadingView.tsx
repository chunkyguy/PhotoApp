// Just a boring spinner

import { ActivityIndicator, StyleSheet, View } from 'react-native';

export default function LoadingView(): JSX.Element {
  return (
    <ActivityIndicator style={{ flex: 1 }} size={'large'} animating={true} />
  );
}
