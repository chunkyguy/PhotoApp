import React from 'react';
import {StyleSheet, Text, View} from 'react-native';

export default function DetailsScreen() {
  return (
    <View style={styles.main}>
      <Text>Details</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  main: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
