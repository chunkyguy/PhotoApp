
import { Button, FlatList, StyleSheet, Text, View } from "react-native";
import { Event, EventHandler } from "../EventHandler";
import PhotoThumbView, { PhotoThumbViewEvent } from "./PhotoThumbView";

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center'
    }
});

export default function PhotoList({ route, navigation }) {

    const { photos } = route.params;

    let eventHandler = ({name, params}) => {
        if (name === "ShowPhoto") {
            navigation.navigate("PhotoDetails", { params });
        } else {
            console.log("Unrecognized event: " + name);
        }
    }

    return (
        <FlatList
            contentContainerStyle={styles.container}
            data={photos}
            renderItem={({ item }) => <PhotoThumbView
                photo={item}
                eventHandler={eventHandler}
            />}
            numColumns={2}
        />
    );
}