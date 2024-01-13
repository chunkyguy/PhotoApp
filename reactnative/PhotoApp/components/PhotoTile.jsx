import React from 'react';
import {View, StyleSheet, Image, Text, Dimensions} from 'react-native';

const styles = StyleSheet.create({
  container: {
    width: Dimensions.get('window').width / 2,
    height: 220,
  },
  content: {
    backgroundColor: '#f2f2f2',
    alignItems: 'center',
    justifyContent: 'flex-end',
    margin: 8,
  },
  image: {
    width: 150,
    height: 150,
  },
  title: {
    fontSize: 18,
    textAlign: 'center',
    paddingTop: 8,
  },
});

export default function PhotoTile({title, thumbnailUrl}) {
  return (
    <View style={styles.container}>
      <View style={styles.content}>
        <Image style={styles.image} source={{uri: thumbnailUrl}} />
        <Text style={styles.title} numberOfLines={2}>
          {title}
        </Text>
      </View>
    </View>
  );
}
