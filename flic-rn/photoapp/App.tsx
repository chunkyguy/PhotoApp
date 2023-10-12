// The main screen
import { useEffect, useState } from 'react';
import { SafeAreaView, StatusBar, StyleSheet } from 'react-native';
import AsyncView from './components/AsyncView';

const styles = StyleSheet.create({
  style: {
    backgroundColor: '#AAA',
  },
});

export default function App(): JSX.Element {
  return (
    <SafeAreaView style={styles.style}>
      <StatusBar
        barStyle={'dark-content'}
        backgroundColor={styles.style.backgroundColor}
      />
      <AsyncView />
    </SafeAreaView>
  );
}
