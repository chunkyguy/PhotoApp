package com.whackylabs.photoapp

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.ViewModelProvider.AndroidViewModelFactory.Companion.APPLICATION_KEY
import androidx.lifecycle.viewModelScope
import androidx.lifecycle.viewmodel.CreationExtras
import androidx.lifecycle.viewmodel.initializer
import androidx.lifecycle.viewmodel.viewModelFactory
import coil.network.HttpException
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import okhttp3.internal.cache.CacheStrategy
import okio.IOException

sealed interface HomeState {
  object Loading : HomeState
  object Error : HomeState
  data class Success(val photos: List<Photo>) : HomeState
}

class HomeViewModel(val photoRepository: PhotoRepository) : ViewModel() {
  private val _state = MutableStateFlow<HomeState>(HomeState.Loading)
  val state: StateFlow<HomeState> = _state.asStateFlow()

  init {
    fetchPhotos()
  }

  fun fetchPhotos() {
    viewModelScope.launch {
      _state.value = HomeState.Loading
      _state.value = try {
        HomeState.Success(photoRepository.getPhotos())
      } catch (e: IOException) {
        HomeState.Error
      } catch (e: HttpException) {
        HomeState.Error
      }
    }
  }

  companion object {
    val Factory: ViewModelProvider.Factory = object : ViewModelProvider.Factory {
      override fun <T : ViewModel> create(modelClass: Class<T>, extras: CreationExtras): T {
        val application = checkNotNull(extras[APPLICATION_KEY])
        val container = (application as PhotoApplication).container
        return HomeViewModel(photoRepository = container.photoRepository) as T
      }
    }
  }
}