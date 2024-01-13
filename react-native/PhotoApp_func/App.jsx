import React from 'react';
import {NavigationContainer} from '@react-navigation/native';
import {createNativeStackNavigator} from '@react-navigation/native-stack';
import HomeScreen from './screens/HomeScreen';
import DetailsScreen from './screens/DetailsScreen';

const Stack = createNativeStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen
          name="Home"
          component={HomeScreen}
          options={{title: 'Photo App'}}
        />
        <Stack.Screen name="Details">
          {props => {
            console.log(props);
            const {photo} = props.route.params;
            return <DetailsScreen photo={photo} />;
          }}
        </Stack.Screen>
      </Stack.Navigator>
    </NavigationContainer>
  );
}
