import { router } from "expo-router";
import React, { useState, useEffect } from "react";
import { ActivityIndicator, SafeAreaView, StyleSheet } from "react-native";
import PhotoList from "../components/photo_list.js";

export default function Home() {
  const [isLoading, setLoading] = useState(true);
  const [photoList, setPhotoList] = useState([]);

  const fetchPhotos = async () => {
    try {
      setLoading(true);
      const res = await fetch("https://jsonplaceholder.typicode.com/photos");
      setPhotoList(await res.json());
    } catch (error) {
      console.error(error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchPhotos();
  }, []);

  return (
    <SafeAreaView style={styles.container}>
      {isLoading ? (
        <ActivityIndicator />
      ) : (
        <PhotoList
          photoList={photoList}
          onSelectPhoto={({ title, url }) => {
            router.push({
              pathname: "/photos/[id]",
              params: { title, url },
            });
          }}
        />
      )}
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});
