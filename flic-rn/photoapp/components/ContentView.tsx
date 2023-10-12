// list of photos

import { FlatList, Image, StyleSheet } from 'react-native';
import type { PropsWithChildren } from 'react';
import PhotoView from './PhotoView';

type Props = PropsWithChildren<{
  numOfColumns: number;
  data: number[];
  fetch: () => void;
}>;

const styles = StyleSheet.create({
  style: {
    width: '100%',
    backgroundColor: '#000',
  },
});

export default function ContentView(props: Props): JSX.Element {
  return (
    <FlatList
      style={styles.style}
      data={props.data}
      numColumns={props.numOfColumns}
      onEndReached={props.fetch}
      keyExtractor={item => item.toString()}
      renderItem={({ item }) => <PhotoView itemId={item} />}
    />
  );
}
