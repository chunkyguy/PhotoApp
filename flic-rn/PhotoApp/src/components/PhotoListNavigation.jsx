import { NavigationContainer } from "@react-navigation/native";
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import PhotoList from "./PhotoList"
import PhotoDetails from "./PhotoDetails"

const Stack = createNativeStackNavigator();

export default function PhotoListNavigation({ photos }) {
    return (
        <NavigationContainer>
            <Stack.Navigator initialRouteName="PhotoList">
                <Stack.Screen
                    name="PhotoList"
                    component={PhotoList}
                    initialParams={{ photos: photos }}
                />
                <Stack.Screen
                    name="PhotoDetails"
                    component={PhotoDetails}
                />
            </Stack.Navigator>
        </NavigationContainer>
    );
}
