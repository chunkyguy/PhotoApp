package com.whackylabs.photoapp

import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.material.ExperimentalMaterialApi
import androidx.compose.material.Surface
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

@OptIn(ExperimentalMaterialApi::class)
@Composable
fun PhotoGridView(
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
    items(
      items = photos,
      key = { photo -> photo.id ?: 0 }
    ) { photo ->
      Surface(onClick = { onSelectPhoto(photo) }) {
        PhotoCardView(
          photoUrl = photo.thumbnailUrl,
          photoTitle = null,
          modifier = Modifier
            .padding(4.dp)
            .fillMaxWidth()
            .aspectRatio(1f)
        )
      }
    }
  }
}