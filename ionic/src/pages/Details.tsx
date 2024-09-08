import { RouteComponentProps } from "react-router-dom";
import {
  IonBackButton,
  IonButtons,
  IonContent,
  IonHeader,
  IonPage,
  IonTitle,
  IonToolbar,
} from "@ionic/react";
import PhotoDetail from "../components/PhotoDetail";

interface UserDetailPageProps
  extends RouteComponentProps<{
    id: string;
  }> {}

export default function Details(props: UserDetailPageProps) {
  return (
    <IonPage>
      <IonHeader>
        <IonToolbar>
          <IonTitle>Photo {props.match.params.id}</IonTitle>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen>
        <IonHeader collapse="condense">
          <IonToolbar>
            <IonButtons slot="start">
              <IonBackButton defaultHref="#"></IonBackButton>
            </IonButtons>
            <IonTitle>Photo {props.match.params.id}</IonTitle>
          </IonToolbar>
        </IonHeader>
        <PhotoDetail id={props.match.params.id} />
      </IonContent>
    </IonPage>
  );
}
