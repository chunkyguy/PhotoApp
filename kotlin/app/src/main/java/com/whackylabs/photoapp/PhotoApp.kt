@file:OptIn(ExperimentalMaterial3Api::class)

package com.whackylabs.photoapp

import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource

@Composable
fun PhotoApp() {
  Scaffold(
    topBar = {
      TopAppBar(title = {
        Text(
          text = stringResource(id = R.string.app_name),
          style = MaterialTheme.typography.headlineSmall
        )
      })
    }
  ) {
    Surface(modifier = Modifier.fillMaxSize()) {
      HomeScreen(contentPadding = it)
    }
  }
}
