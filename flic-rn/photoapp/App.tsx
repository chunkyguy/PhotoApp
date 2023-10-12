import { useEffect, useState } from 'react';
import { SafeAreaView, StatusBar, StyleSheet } from 'react-native';
import { Colors } from 'react-native/Libraries/NewAppScreen';
import ContentView from './components/ContentView';

const styles = StyleSheet.create({
  background: {
    backgroundColor: Colors.darker,
  },
});

export default function App(): JSX.Element {
  const [data, setData] = useState<Array<number>>([]);

  useEffect(() => {
    fetch();
  }, []);

  const fetch = () => {
    setData(prevData => [
      ...prevData,
      ...Array.from({ length: 9 }).map((_, i) => i + 1 + prevData.length),
    ]);
  };

  return (
    <SafeAreaView style={styles.background}>
      <StatusBar
        barStyle={'light-content'}
        backgroundColor={styles.background.backgroundColor}
      />
      <ContentView data={data} fetch={fetch} />
    </SafeAreaView>
  );
}
