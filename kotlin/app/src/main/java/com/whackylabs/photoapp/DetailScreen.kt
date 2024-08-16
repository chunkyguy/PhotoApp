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
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Surface

@Composable
fun DetailScreen(
  id: String,
  viewModel: DetailViewModel = viewModel(factory = DetailViewModel.Factory),
  modifier: Modifier = Modifier,
  contentPadding: PaddingValues = PaddingValues(0.dp)
) {
  val state by viewModel.state.collectAsState()
  when (state) {
    is DetailState.Loading -> LoadingView(modifier = modifier.fillMaxSize())

    is DetailState.Error -> ErrorView(
      onClick = { viewModel.fetchPhoto(id) },
      modifier = modifier.fillMaxSize()
    )

    is DetailState.Success -> DetailSuccessView(
      photo = (state as DetailState.Success).photo,
      modifier = modifier.fillMaxWidth(),
      contentPadding = contentPadding
    )
  }
  viewModel.fetchPhoto(id)
}

@Composable
private fun DetailSuccessView(
  photo: Photo,
  modifier: Modifier,
  contentPadding: PaddingValues = PaddingValues(0.dp),
) {
  Surface(modifier = modifier) {
    PhotoCardView(
      photoUrl = photo.url,
      photoTitle = photo.title,
      modifier = Modifier
        .padding(4.dp)
        .fillMaxWidth()
        .aspectRatio(1f)
    )
  }

}
