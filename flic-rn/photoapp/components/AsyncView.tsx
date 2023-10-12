// View with 3 states: loading, error, success

import { useState, useEffect } from 'react';
import { StyleSheet, Text, View } from 'react-native';
import PhotoListView from './PhotoListView';
import LoadingView from './LoadingView';

const styles = StyleSheet.create({
  style: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});

export default function AsyncView(): JSX.Element {
  const numOfColumns = 2;
  const [data, setData] = useState<number[]>([]);
  const [error, setError] = useState<string>('');

  const fetch = (count: number) => {
    setData(prevData => [
      ...prevData,
      ...Array.from({ length: count }).map((_, i) => i + 1 + prevData.length),
    ]);
  };

  const fetchMore = () => {
    fetch(numOfColumns);
  };

  useEffect(() => {
    // first fetch load enough photos to fill screen
    fetch(numOfColumns * 5);
  }, []);

  if (data.length == 0) {
    return (
      <View style={styles.style}>
        <LoadingView />
      </View>
    );
  }

  if (error.length > 0) {
    return <Text>{error}</Text>;
  }

  return (
    <PhotoListView
      numOfColumns={numOfColumns}
      data={data}
      fetchMore={fetchMore}
    />
  );
}
