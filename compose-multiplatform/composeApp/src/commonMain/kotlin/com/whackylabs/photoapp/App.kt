package com.whackylabs.photoapp

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Button
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import kotlinx.coroutines.launch
import org.jetbrains.compose.resources.painterResource
import org.jetbrains.compose.ui.tooling.preview.Preview

import photoapp.composeapp.generated.resources.Res
import photoapp.composeapp.generated.resources.compose_multiplatform

@Composable
@Preview
fun App() {
  MaterialTheme {
    Surface(
      modifier = Modifier.fillMaxSize(),
      color = MaterialTheme.colors.background,
    ) {
      val scope = rememberCoroutineScope()
      val navController = rememberNavController()
      var photos: List<Photo> by remember { mutableStateOf(emptyList()) }
      LaunchedEffect(true) {
        scope.launch {
          photos = try {
            NetworkService().photos()
          } catch (e: Exception) {
            emptyList()
          }
        }
      }
      NavHost(
        navController = navController,
        startDestination = "home"
      ) {
        composable("home") {
          PhotoGridView(
            onSelectPhoto = { navController.navigate("photos/${it.id}") },
            photos = photos
          )
        }
        composable("photos/{id}") { entry ->
          val photoId = entry.arguments?.getString("id") ?: "0"
          val photo = photos.first { it.id.toString() == photoId }
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
    }
  }
}