import React from 'react';
import {StyleSheet, Text, View, Image} from 'react-native';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: 8,
  },
  image: {
    width: 300,
    height: 300,
  },
  title: {
    fontSize: 18,
    textAlign: 'center',
    paddingTop: 8,
  },
});

export default function DetailsScreen({photo}) {
  const {title, url} = photo;
  return (
    <View style={styles.container}>
      <Image style={styles.image} source={{uri: url}} />
      <Text style={styles.title}>{title}</Text>
    </View>
  );
}
