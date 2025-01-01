package com.whackylabs.photoapp.android

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
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
          PhotoGridView(
            onSelectPhoto = {
              println("show photo ${it.id}")
            },
            photos = photos
          )
        }
      }
    }
  }
}
