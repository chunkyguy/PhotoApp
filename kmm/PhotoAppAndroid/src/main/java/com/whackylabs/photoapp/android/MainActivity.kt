package com.whackylabs.photoapp.android

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.whackylabs.photoapp.NetworkService
import com.whackylabs.photoapp.Photo
import kotlinx.coroutines.launch

class MainActivity : ComponentActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContent {
      MyApplicationTheme {
        Surface(
          modifier = Modifier.fillMaxSize(),
          color = MaterialTheme.colorScheme.background
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
          NavHost(navController = navController, startDestination = "home") {
            composable("home") {
              PhotoGridView(
                onSelectPhoto = { navController.navigate("photos/${it.id}") },
                photos = photos
              )
            }
            composable("photos/{id}") {
              val photoId = it.arguments?.getString("id") ?: "0"
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
  }
}
