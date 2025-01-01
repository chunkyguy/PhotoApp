package com.whackylabs.photoapp.android

import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.MaterialTheme
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
  Card(
    modifier = modifier,
    shape = MaterialTheme.shapes.medium,
    elevation = CardDefaults.cardElevation(defaultElevation = 8.dp)
  ) {
    AsyncImage(
      model = photoUrl,
      contentDescription = photoTitle,
      contentScale = ContentScale.Crop,
      modifier = Modifier.fillMaxWidth(),
    )
  }
}