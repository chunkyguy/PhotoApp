import { StyleSheet, Text, View } from "react-native";

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center' 
    }
});

export default function ErrorView({ message }) {
    return (
        <View>
            <Text>{message}</Text>
        </View>
    );
}