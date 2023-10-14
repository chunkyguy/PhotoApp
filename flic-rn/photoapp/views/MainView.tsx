// View with 3 states: loading, error, success

import { useState, useEffect } from 'react';
import { StyleSheet, Text, View } from 'react-native';
import PhotoListView from './PhotoListView';
import LoadingView from './LoadingView';
import Constants from '../models/Constants';
import Photo from '../models/Photo';

const styles = StyleSheet.create({
  style: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});

export default function MainView(): JSX.Element {
  const numOfColumns = 2;
  const [photoList, setPhotoList] = useState<Photo[]>([]);
  const [error, setError] = useState<string>('');

  useEffect(() => {
    fetch(Constants.photoListURL)
      .then(resp => resp.json())
      .then(json => setPhotoList(json))
      .catch(err => setError(err));
  }, []);

  if (error.length > 0) {
    return <Text>{error}</Text>;
  }

  if (photoList.length == 0) {
    return (
      <View style={styles.style}>
        <LoadingView />
      </View>
    );
  }

  return <PhotoListView numOfColumns={numOfColumns} photoList={photoList} />;
}
