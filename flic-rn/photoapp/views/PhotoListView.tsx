// list of photos

import { FlatList, Image, StyleSheet } from 'react-native';
import PhotoView from './PhotoView';
import Photo from '../models/Photo';

type Props = {
  numOfColumns: number;
  photoList: Photo[];
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
      data={props.photoList}
      numColumns={props.numOfColumns}
      keyExtractor={item => item.id.toString()}
      renderItem={({ item }) => <PhotoView photo={item} />}
    />
  );
}
