import { useEffect, useState } from 'react';
import {
  FlatList,
  Image,
  SafeAreaView,
  StatusBar,
  StyleSheet,
  Text,
} from 'react-native';
import { Colors, Header } from 'react-native/Libraries/NewAppScreen';

const BASE_URI = 'https://source.unsplash.com/random?sig=';

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
      <FlatList
        style={styles.list}
        data={data}
        numColumns={3}
        onEndReached={fetch}
        keyExtractor={item => item.toString()}
        renderItem={({ item }) => (
          <Image style={styles.item} source={{ uri: BASE_URI + item }} />
        )}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  background: {
    backgroundColor: Colors.darker,
  },
  list: {
    width: '100%',
    backgroundColor: '#000',
  },
  item: {
    backgroundColor: '#EEE',
    aspectRatio: 1,
    width: '100%',
    flex: 1,
  },
});
