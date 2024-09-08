import { useEffect, useState } from "react";
import PhotoTile from "./PhotoTile";
import { Photo } from "../types/Photo";
import { IonSpinner } from "@ionic/react";

export type PhotoDetailProps = {
  id: string;
};

export default function PhotoDetail(props: PhotoDetailProps) {
  const [photo, setPhoto] = useState<Photo | undefined>(undefined);

  async function fetchData() {
    const response = await fetch(
      `https://jsonplaceholder.typicode.com/photos/${props.id}`
    );
    const content = await response.json();
    const photo = content as Photo;
    setPhoto(photo);
  }

  useEffect(() => {
    fetchData();
  }, []);

  return !photo ? (
    <IonSpinner />
  ) : (
    <PhotoTile
      photoTitle={photo.title}
      photoUrl={photo.url}
      routerLink="/home"
    />
  );
}
