package com.whackylabs.photoapp

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch

class PhotoListViewModel : ViewModel() {
    sealed class State {
        data object Loading : State()
        data class Error(val message: String) : State()
        data class Content(val photos: List<Photo>) : State()
    }

    private val networkService = NetworkService()
    private val _state = MutableStateFlow<State>(State.Loading)
    val state: StateFlow<State> = _state

    fun fetchPhotos() {
        viewModelScope.launch {
            _state.value = State.Loading
            try {
                val photos = networkService.photos()
                _state.value = State.Content(photos)
            } catch (e: Exception) {
                val message = e.message ?: "Something went wrong"
                _state.value = State.Error(message)
            }
        }
    }
}