// list of photos

import { FlatList, Image, StyleSheet } from 'react-native';
import PhotoView from './PhotoView';

type Props = {
  numOfColumns: number;
  data: number[];
  fetchMore: () => void;
};

const styles = StyleSheet.create({
  style: {
    width: '100%',
    backgroundColor: '#000',
  },
});

export default function PhotoListView(props: Props): JSX.Element {
  return (
    <FlatList
      style={styles.style}
      data={props.data}
      numColumns={props.numOfColumns}
      onEndReached={props.fetchMore}
      keyExtractor={item => item.toString()}
      renderItem={({ item }) => <PhotoView itemId={item} />}
    />
  );
}
