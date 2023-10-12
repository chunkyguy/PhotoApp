import { FlatList, Image, StyleSheet } from 'react-native';
import type { PropsWithChildren } from 'react';
import { Colors } from 'react-native/Libraries/NewAppScreen';

const BASE_URI = 'https://source.unsplash.com/random?sig=';

type Props = PropsWithChildren<{
  data: number[];
  fetch: () => void;
}>;

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

export default function ContentView(props: Props): JSX.Element {
  return (
    <FlatList
      style={styles.list}
      data={props.data}
      numColumns={3}
      onEndReached={props.fetch}
      keyExtractor={item => item.toString()}
      renderItem={({ item }) => (
        <Image style={styles.item} source={{ uri: BASE_URI + item }} />
      )}
    />
  );
}
