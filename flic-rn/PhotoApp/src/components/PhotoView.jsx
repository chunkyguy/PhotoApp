import React from "react";
import { Image, StyleSheet, TouchableOpacity, View } from "react-native";

const styles = StyleSheet.create({
    container: {
        padding: 8
    }
});

export default function PhotoView({ photoUrl, size, event, eventHandler }) {
    return <View style={styles.container}>
        <TouchableOpacity onPress={() => { eventHandler(event) }}>
            <Image
                style={{ width: size, height: size }}
                source={{ uri: photoUrl }}
            />
        </TouchableOpacity>
    </View>
}
