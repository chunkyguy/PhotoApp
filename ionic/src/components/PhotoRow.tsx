import { IonRow } from "@ionic/react";
import PhotoTile, { PhotoTileProps } from "./PhotoTile";

export type PhotoRowProps = {
  tiles: Array<PhotoTileProps>;
};

export default function PhotoRow(props: PhotoRowProps) {
  return (
    <IonRow>
      {props.tiles.map((elem, index) => (
        <PhotoTile
          key={index}
          routerLink={elem.routerLink}
          photoTitle={elem.photoTitle}
          photoUrl={elem.photoUrl}
        />
      ))}
    </IonRow>
  );
}
