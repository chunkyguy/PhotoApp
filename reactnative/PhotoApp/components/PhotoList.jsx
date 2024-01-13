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

<PhotoList photoList={kPhotoList} />
*/

export default function PhotoList({photoList}) {
  return (
    <FlatList
      data={photoList}
      renderItem={itemInfo => {
        const {item} = itemInfo;
        const {title, thumbnailUrl} = item;
        return <PhotoTile title={title} thumbnailUrl={thumbnailUrl} />;
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
