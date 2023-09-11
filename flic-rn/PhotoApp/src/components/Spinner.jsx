import React from "react";
import { ActivityIndicator, StyleSheet, View } from "react-native";

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center'
    },
});

export default function Spinner({ isAnimating = true }) {
    return (
        <View style={styles.container}>
            <ActivityIndicator animating></ActivityIndicator>
        </View>
    );
}
