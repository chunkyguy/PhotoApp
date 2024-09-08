import { IonCard, IonCol, IonImg, IonLabel } from "@ionic/react";

export type PhotoTileProps = {
  routerLink: string;
  photoUrl: string | undefined;
  photoTitle: string | undefined;
};

export default function PhotoTile(props: PhotoTileProps) {
  return (
    <IonCard routerLink={props.routerLink}>
      <IonCol>
        <IonImg src={props.photoUrl} />
        {props.photoTitle && <IonLabel>{props.photoTitle}</IonLabel>}
      </IonCol>
    </IonCard>
  );
}
