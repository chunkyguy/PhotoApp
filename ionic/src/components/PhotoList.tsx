import { useEffect, useState } from "react";
import {
  IonContent,
  IonGrid,
  IonInfiniteScroll,
  IonInfiniteScrollContent,
} from "@ionic/react";
import { PhotoTileProps } from "./PhotoTile";
import PhotoRow, { PhotoRowProps } from "./PhotoRow";
import { Photo } from "../types/Photo";

export default function PhotoList() {
  const [photoList, setPhotoList] = useState<Array<PhotoRowProps>>([]);

  function createPhotoTileProps(photo: Photo): PhotoTileProps {
    return {
      routerLink: `/details/${photo.id}`,
      photoTitle: undefined,
      photoUrl: photo.thumbnailUrl,
    };
  }

  async function fetchData() {
    const response = await fetch("https://jsonplaceholder.typicode.com/photos");
    const content = await response.json();
    const list = content as Photo[];
    let props: Array<PhotoRowProps> = [];
    for (let index = 0; index < list.length; index += 2) {
      const elem: PhotoRowProps = {
        tiles: [
          createPhotoTileProps(list[index]),
          createPhotoTileProps(list[index + 1]),
        ],
      };
      props.push(elem);
    }
    setPhotoList(props);
  }

  useEffect(() => {
    fetchData();
  }, []);

  return (
    <IonContent>
      <IonGrid>
        {photoList.map((item, index) => (
          <PhotoRow key={index} tiles={item.tiles} />
        ))}
      </IonGrid>
      <IonInfiniteScroll>
        <IonInfiniteScrollContent></IonInfiniteScrollContent>
      </IonInfiniteScroll>
    </IonContent>
  );
}
