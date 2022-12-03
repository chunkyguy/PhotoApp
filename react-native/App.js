import React, { Component } from 'react';
import { Text, View, FlatList, ActivityIndicator, Image } from 'react-native';

class ImageTile extends Component {
  render() {
    return <View>
      <Image source={{ uri: this.props.source }} style={{ width: 150, height: 150 }} />
      <Text>{this.props.title}</Text>
    </View>
  }
}

export default class PhotoApp extends Component {

  constructor(props) {
    super(props)
    this.state = { isLoading: true, title: 'Loading ...' };
  }

  componentDidMount() {
    return fetch('https://jsonplaceholder.typicode.com/photos')
      .then((response) => response.json())
      .then((responseJson) => {
        this.setState({
          isLoading: false,
          title: 'Photo App',
          dataSource: responseJson,
        }, function () {

        });
      })
      .catch((error) => {
        console.error(error);
      });
  }

  render() {

    if (this.state.isLoading) {
      return (
        <View style={{ flex: 1, padding: 20 }}>
          <ActivityIndicator />
        </View>
      );
    }

    return (
      <View style={{ padding: 100 }}>
        <Text style={{ fontSize: 32 }}>{this.state.title}</Text>
        <FlatList
          data={this.state.dataSource}
          renderItem={({ item }) => <ImageTile
            source={item.thumbnailUrl}
            title={item.title}
          />}
          keyExtractor={({ id }, index) => id}
        />

      </View>
    );
  }
}
