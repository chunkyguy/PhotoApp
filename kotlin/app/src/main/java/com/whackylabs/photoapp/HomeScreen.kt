package com.whackylabs.photoapp

import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.lifecycle.viewmodel.compose.viewModel

import androidx.compose.ui.UiComposable
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp
import coil.compose.AsyncImage
import coil.request.ImageRequest

@Composable
fun HomeScreen(
  viewModel: HomeViewModel = viewModel(factory = HomeViewModel.Factory),
  modifier: Modifier = Modifier,
  contentPadding: PaddingValues = PaddingValues(0.dp)
) {
  val state by viewModel.state.collectAsState()
  when (state) {
    is HomeState.Loading -> LoadingScreen(modifier = modifier.fillMaxSize())

    is HomeState.Error -> ErrorScreen(
      onClick = { viewModel.fetchPhotos() },
      modifier = modifier.fillMaxSize()
    )

    is HomeState.Success -> PhotoGridScreen(
      photos = (state as HomeState.Success).photos,
      modifier = modifier.fillMaxWidth(),
      contentPadding = contentPadding
    )
  }
}

@Composable
private fun LoadingScreen(modifier: Modifier = Modifier) {
  Image(
    modifier = modifier.size(200.dp),
    painter = painterResource(id = R.drawable.loading_img),
    contentDescription = "Loading"
  )
}

@Composable
private fun ErrorScreen(onClick: () -> Unit, modifier: Modifier = Modifier) {
  Column(
    modifier = modifier,
    verticalArrangement = Arrangement.Center,
    horizontalAlignment = Alignment.CenterHorizontally,
  ) {
    Image(
      painter = painterResource(id = R.drawable.ic_connection_error),
      contentDescription = "Error",
    )
    Text(text = "Error. Please try again", modifier = Modifier.padding(16.dp))
    Button(onClick = { onClick() }) {
      Text(text = "Retry")
    }
  }
}

@Composable
private fun PhotoCard(photo: Photo, modifier: Modifier = Modifier) {
  Card(
    modifier = modifier,
    shape = MaterialTheme.shapes.medium,
    elevation = CardDefaults.cardElevation(defaultElevation = 8.dp)
  ) {
    AsyncImage(
      model = ImageRequest.Builder(context = LocalContext.current).data(photo.thumbnailUrl)
        .crossfade(true).build(),
      contentDescription = photo.title,
      error = painterResource(id = R.drawable.ic_broken_image),
      placeholder = painterResource(id = R.drawable.loading_img),
      contentScale = ContentScale.Crop,
      modifier = Modifier.fillMaxWidth(),
    )
  }
}

@Composable
private fun PhotoGridScreen(
  photos: List<Photo>,
  modifier: Modifier = Modifier,
  contentPadding: PaddingValues = PaddingValues(0.dp),
) {
  LazyVerticalGrid(
    columns = GridCells.Adaptive(150.dp),
    modifier = modifier.padding(horizontal = 4.dp),
    contentPadding = contentPadding,
  ) {
    items(items = photos, key = { photo -> photo.id }) { photo: Photo ->
      PhotoCard(
        photo = photo, modifier = Modifier
          .padding(4.dp)
          .fillMaxWidth()
          .aspectRatio(1f)
      )
    }
  }
}