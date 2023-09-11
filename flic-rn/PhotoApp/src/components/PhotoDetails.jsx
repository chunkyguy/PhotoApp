import { View, Text, StyleSheet, Button } from 'react-native';
import PhotoFullView, { PhotoFullViewEvent } from "./PhotoFullView";
import { Event, EventHandler } from "../EventHandler";

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center'
    }
});

export default function PhotoDetails({ route, navigation }) {
    let eventHandler = ({event}) => {
        console.log("Pop back");
    }

    const { photo } = route.params;

    return (
        <View style={styles.container}>
            <PhotoFullView
                photo={photo}
                eventHandler={eventHandler}
            />
        </View>
    );
}
