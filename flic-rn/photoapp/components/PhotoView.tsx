// photo tile

import { PropsWithChildren } from 'react';
import { Image, StyleSheet } from 'react-native';

const BASE_URI = 'https://source.unsplash.com/random?sig=';

type Props = {
  itemId: number;
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
    <Image style={styles.style} source={{ uri: BASE_URI + props.itemId }} />
  );
}
