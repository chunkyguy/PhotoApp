package com.whackylabs.photoapp

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.ViewModelProvider.AndroidViewModelFactory.Companion.APPLICATION_KEY
import androidx.lifecycle.viewModelScope
import androidx.lifecycle.viewmodel.CreationExtras
import coil.network.HttpException
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import okio.IOException

sealed interface DetailState {
  object Loading : DetailState
  object Error : DetailState
  data class Success(val photo: Photo) : DetailState
}

class DetailViewModel(val photoRepository: PhotoRepository) : ViewModel() {
  private val _state = MutableStateFlow<DetailState>(DetailState.Loading)
  val state: StateFlow<DetailState> = _state.asStateFlow()

  fun fetchPhoto(id: String) {
    viewModelScope.launch {
      _state.value = DetailState.Loading
      _state.value = try {
        photoRepository.getPhoto(id = id)?.let { DetailState.Success(it) } ?: DetailState.Error
      } catch (e: IOException) {
        DetailState.Error
      } catch (e: HttpException) {
        DetailState.Error
      }
    }
  }

  companion object {
    val Factory: ViewModelProvider.Factory = object : ViewModelProvider.Factory {
      override fun <T : ViewModel> create(modelClass: Class<T>, extras: CreationExtras): T {
        val application = checkNotNull(extras[APPLICATION_KEY])
        val container = (application as PhotoApplication).container
        return DetailViewModel(photoRepository = container.photoRepository) as T
      }
    }
  }
}