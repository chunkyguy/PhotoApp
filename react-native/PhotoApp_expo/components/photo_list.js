import React from "react";
import { FlatList } from "react-native";
import PhotoTile from "./photo_tile";
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

<PhotoList photoList={kPhotoList} onSelectPhoto:(kPhoto)=>void />
*/

export default function PhotoList({ photoList, onSelectPhoto }) {
  return (
    <FlatList
      data={photoList}
      renderItem={(itemInfo) => {
        const { item } = itemInfo;
        return <PhotoTile photo={item} onSelectPhoto={onSelectPhoto} />;
      }}
      keyExtractor={(item) => {
        const { id } = item;
        return id;
      }}
      horizontal={false}
      numColumns={2}
    />
  );
}
