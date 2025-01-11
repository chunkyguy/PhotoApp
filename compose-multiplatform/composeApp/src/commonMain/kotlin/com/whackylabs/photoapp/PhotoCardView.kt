package com.whackylabs.photoapp

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.material.Card
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.unit.dp
import coil3.compose.AsyncImage

@Composable
fun PhotoCardView(
  photoUrl: String?,
  photoTitle: String?,
  modifier: Modifier = Modifier
) {
  Column {
    Card(
      modifier = modifier,
      shape = MaterialTheme.shapes.medium,
      elevation = 8.dp,
    ) {
      AsyncImage(
        model = photoUrl,
        contentDescription = photoTitle,
        contentScale = ContentScale.Crop,
        modifier = Modifier.fillMaxWidth(),
      )
    }
    Text(photoTitle ?: "")
  }
}