import React, { useEffect, useState } from "react";
import { Text, View, StyleSheet } from "react-native";
import Spinner from "./Spinner";
import PhotoListNavigation from "./PhotoListNavigation";
import ErrorView from "./ErrorView";

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center'
    },
});

export default function AsyncView({ url }) {

    const [photos, setPhotos] = useState([]);
    const [error, setError] = useState('');

    useEffect(() => {
        fetch(url)
            .then((resp) => resp.json())
            .then((json) => setPhotos(json))
            .catch((err) => setError(err))
    }, []);

    if (photos.length > 0) {
        return (<PhotoListNavigation photos={photos} />);
    }
    else if (error.length > 0) {
        return (<ErrorView message={error} />);
    }
    else {
        return( <Spinner />);
    }
};
