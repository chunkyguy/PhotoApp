// photo tile

import { Image, StyleSheet } from 'react-native';
import Photo from '../models/Photo';

type Props = {
  photo: Photo;
};

const styles = StyleSheet.create({
  style: {
    backgroundColor: '#FFF',
    aspectRatio: 1,
    width: '100%',
    flex: 1,
  },
});

export default function PhotoView(props: Props): JSX.Element {
  return (
    <Image style={styles.style} source={{ uri: props.photo.thumbnailUrl }} />
  );
}
