import { StyleSheet } from 'react-native';
import AsyncView from './components/AsyncView';
import { colors } from './Theme';

const styles = StyleSheet.create({
  header: {
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: colors.headerBackground,
    height: 64,
  },
  headerTitle: {
    fontSize: 32,
    color: colors.textColor,
  }
});

export default function App() {
  /**
  [{
    "albumId": 1,
    "id": 1,
    "title": "accusamus beatae ad facilis cum similique qui sunt",
    "url": "https://via.placeholder.com/600/92c952",
    "thumbnailUrl": "https://via.placeholder.com/150/92c952"
  },...]
   */
  return (
      <AsyncView url='https://jsonplaceholder.typicode.com/photos' />
  );
}
