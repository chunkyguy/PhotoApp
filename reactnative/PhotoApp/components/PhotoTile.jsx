import React from 'react';
import {
  View,
  StyleSheet,
  Image,
  Text,
  Dimensions,
  TouchableOpacity,
} from 'react-native';

/*
const kPhoto = {
  albumId: 1,
  id: 1,
  title: 'accusamus beatae ad facilis cum similique qui sunt',
  url: 'https://via.placeholder.com/600/92c952',
  thumbnailUrl: 'https://via.placeholder.com/150/92c952',
};

<PhotoTile photo={kPhoto} navigation={navigation} />
*/

export default function PhotoTile({photo, navigation}) {
  const {title, thumbnailUrl} = photo;

  const handleTap = () => {
    navigation.navigate('Details', {
      photo,
    });
  };

  return (
    <View style={styles.container}>
      <TouchableOpacity style={styles.content} onPress={handleTap}>
        <Image style={styles.image} source={{uri: thumbnailUrl}} />
        <Text style={styles.title} numberOfLines={2}>
          {title}
        </Text>
      </TouchableOpacity>
    </View>
  );
}

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
