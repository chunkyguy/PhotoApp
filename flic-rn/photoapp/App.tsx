// The main screen
import { SafeAreaView, StatusBar, StyleSheet } from 'react-native';
import AsyncView from './components/AsyncView';

const styles = StyleSheet.create({
  style: {
    backgroundColor: '#AAA',
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});

export default function App(): JSX.Element {
  return (
    <SafeAreaView style={styles.style}>
      <StatusBar
        barStyle={'dark-content'}
        backgroundColor={styles.style.backgroundColor}
      />
      <AsyncView />
    </SafeAreaView>
  );
}
