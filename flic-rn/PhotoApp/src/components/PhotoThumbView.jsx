import React from "react";
import PhotoView from "./PhotoView";

export default function PhotoThumbView({ photo, eventHandler }) {
    return <PhotoView
        photoUrl={photo.thumbnailUrl}
        size={150}
        event={{name: "ShowPhoto", params: {photo: photo}}}
        eventHandler={eventHandler}
    />
}
