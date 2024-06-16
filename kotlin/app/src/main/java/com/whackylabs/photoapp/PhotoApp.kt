@file:OptIn(ExperimentalMaterial3Api::class)

package com.whackylabs.photoapp


import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import  androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.material3.TopAppBarDefaults.enterAlwaysScrollBehavior
import androidx.compose.material3.TopAppBarScrollBehavior
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.res.stringResource
import androidx.lifecycle.viewmodel.compose.viewModel

@Composable
fun PhotoApp() {
  val scrollBehavior = TopAppBarDefaults.enterAlwaysScrollBehavior()
  Scaffold(
    modifier = Modifier.nestedScroll(scrollBehavior.nestedScrollConnection),
    topBar = { PHTopAppBar(scrollBehavior = scrollBehavior) },
  ) {
    Surface(modifier = Modifier.fillMaxSize()) {
      HomeScreen(contentPadding = it)
    }
  }
}

@Composable
fun PHTopAppBar(scrollBehavior: TopAppBarScrollBehavior, modifier: Modifier = Modifier) {
  CenterAlignedTopAppBar(
    scrollBehavior = scrollBehavior,
    title = {
      Text(
        text = stringResource(id = R.string.app_name),
        style = MaterialTheme.typography.headlineSmall
      )
    },
    modifier = modifier,
  )
}