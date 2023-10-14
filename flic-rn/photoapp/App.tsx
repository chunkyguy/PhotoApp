// The main screen

import { SafeAreaView, StatusBar, StyleSheet } from 'react-native';
import MainView from './views/MainView';

const styles = StyleSheet.create({
  style: {
    backgroundColor: '#000',
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});

export default function App(): JSX.Element {
  return (
    <SafeAreaView style={styles.style}>
      <StatusBar
        barStyle={'light-content'}
        backgroundColor={styles.style.backgroundColor}
      />
      <MainView />
    </SafeAreaView>
  );
}
