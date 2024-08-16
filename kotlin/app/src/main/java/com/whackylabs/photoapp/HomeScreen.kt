@file:OptIn(ExperimentalMaterial3Api::class)

package com.whackylabs.photoapp

import LoadingView
import PhotoCardView
import ErrorView
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavController
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Surface

@Composable
fun HomeScreen(
  onSelectPhoto: (Photo) -> Unit,
  viewModel: HomeViewModel = viewModel(factory = HomeViewModel.Factory),
  modifier: Modifier = Modifier,
  contentPadding: PaddingValues = PaddingValues(0.dp)
) {
  val state by viewModel.state.collectAsState()
  when (state) {
    is HomeState.Loading -> LoadingView(modifier = modifier.fillMaxSize())

    is HomeState.Error -> ErrorView(
      onClick = { viewModel.fetchPhotos() },
      modifier = modifier.fillMaxSize()
    )

    is HomeState.Success -> HomeSuccessView(
      onSelectPhoto = onSelectPhoto,
      photos = (state as HomeState.Success).photos,
      modifier = modifier.fillMaxWidth(),
      contentPadding = contentPadding
    )
  }
}

@Composable
private fun HomeSuccessView(
  onSelectPhoto: (Photo) -> Unit,
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
      Surface(onClick = { onSelectPhoto(photo) }) {
        PhotoCardView(
          photoUrl = photo.thumbnailUrl,
          photoTitle = photo.title,
          modifier = Modifier
            .padding(4.dp)
            .fillMaxWidth()
            .aspectRatio(1f)
        )
      }
    }
  }
}

