import React from 'react';
import {FlatList} from 'react-native';
import PhotoTile from './PhotoTile';
/*
const kPhotoList = [
  {
    albumId: 1,
    id: 1,
    title: 'accusamus beatae ad facilis cum similique qui sunt',
    url: 'https://via.placeholder.com/600/92c952',
    thumbnailUrl: 'https://via.placeholder.com/150/92c952',
  },
]

<PhotoList photoList={kPhotoList} navigation={navigation} />
*/

export default function PhotoList({photoList, navigation}) {
  return (
    <FlatList
      data={photoList}
      renderItem={itemInfo => {
        const {item} = itemInfo;
        return <PhotoTile photo={item} navigation={navigation} />;
      }}
      keyExtractor={item => {
        const {id} = item;
        return id;
      }}
      horizontal={false}
      numColumns={2}
    />
  );
}
