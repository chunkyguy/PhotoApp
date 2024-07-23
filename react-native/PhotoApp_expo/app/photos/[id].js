import { useLocalSearchParams } from "expo-router";
import React from "react";
import { StyleSheet, Text, Image } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";

/*
const kPhoto = {
  albumId: 1,
  id: 1,
  title: 'accusamus beatae ad facilis cum similique qui sunt',
  url: 'https://via.placeholder.com/600/92c952',
  thumbnailUrl: 'https://via.placeholder.com/150/92c952',
};

<DetailsScreen />
*/

export default function DetailsScreen() {
  const { title, url } = useLocalSearchParams();
  return (
    <SafeAreaView style={styles.container}>
      <Image style={styles.image} source={{ uri: url }} />
      <Text style={styles.title}>{title}</Text>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
    padding: 8,
  },
  image: {
    width: 300,
    height: 300,
  },
  title: {
    fontSize: 18,
    textAlign: "center",
    paddingTop: 8,
  },
});
