import React from "react";
import PhotoView from "./PhotoView";

export default function PhotoFullView({ photo, eventHandler }) {
    return <PhotoView
        photoUrl={photo.url}
        size={300}
        event={photo}
        eventHandler={eventHandler}
    />
}
