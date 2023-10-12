// The main screen
import { useEffect, useState } from 'react';
import { SafeAreaView, StatusBar, StyleSheet } from 'react-native';
import ContentView from './components/ContentView';

const styles = StyleSheet.create({
  style: {
    backgroundColor: '#EEE',
  },
});

export default function App(): JSX.Element {
  const numOfColumns = 2;
  const itemsPerFetch = 10;
  const [data, setData] = useState<Array<number>>([]);

  useEffect(() => {
    fetch();
  }, []);

  const fetch = () => {
    setData(prevData => [
      ...prevData,
      ...Array.from({ length: itemsPerFetch }).map(
        (_, i) => i + 1 + prevData.length,
      ),
    ]);
  };

  return (
    <SafeAreaView style={styles.style}>
      <StatusBar
        barStyle={'dark-content'}
        backgroundColor={styles.style.backgroundColor}
      />
      <ContentView numOfColumns={numOfColumns} data={data} fetch={fetch} />
    </SafeAreaView>
  );
}
