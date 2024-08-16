@file:OptIn(ExperimentalMaterial3Api::class)

package com.whackylabs.photoapp

import androidx.compose.runtime.Composable
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.currentBackStackEntryAsState
import androidx.navigation.compose.rememberNavController

@Composable
fun PhotoAppBar(
  canNavigateBack: Boolean,
  navigateUp: () -> Unit,
  modifier: Modifier = Modifier
) {
  TopAppBar(title = {
    Text(
      text = "Photo App",
      style = MaterialTheme.typography.headlineSmall
    )
  },
    modifier = modifier,
    navigationIcon = {
      if (canNavigateBack) {
        IconButton(onClick = navigateUp) {
          Icon(
            imageVector = Icons.AutoMirrored.Filled.ArrowBack,
            contentDescription = "Back"
          )
        }
      }
    }
  )
}

@Composable
fun PhotoApp(
  navController: NavHostController = rememberNavController()
) {
  Scaffold(
    topBar = {
      PhotoAppBar(
        canNavigateBack = navController.previousBackStackEntry != null,
        navigateUp = { navController.navigateUp() }
      )
    }
  ) { innerPadding ->
    NavHost(
      navController = navController,
      startDestination = "home",
      modifier = Modifier
        .fillMaxSize()
        .padding(innerPadding)
    ) {
      composable("home") {
        HomeScreen(
          onSelectPhoto = { navController.navigate("photos/${it.id}") },
          modifier = Modifier.fillMaxSize()
        )
      }

      composable("photos/{id}") {
        DetailScreen(
          id = it.arguments?.getString("id") ?: "0",
          modifier = Modifier.fillMaxSize()
        )
      }
    }
  }
}
