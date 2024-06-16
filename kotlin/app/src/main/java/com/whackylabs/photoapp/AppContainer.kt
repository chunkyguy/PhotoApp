package com.whackylabs.photoapp

import com.jakewharton.retrofit2.converter.kotlinx.serialization.asConverterFactory
import kotlinx.serialization.json.Json
import retrofit2.Retrofit
import okhttp3.MediaType.Companion.toMediaType

interface AppContainer {
  val photoRepository: PhotoRepository
}

class AppContainerImpl : AppContainer {
  private val baseUrl = "https://jsonplaceholder.typicode.com/"
  private val retrofit = Retrofit.Builder()
    .addConverterFactory(Json.asConverterFactory("application/json".toMediaType()))
    .baseUrl(baseUrl)
    .build()

  private val networkService: NetworkService by lazy {
    retrofit.create(NetworkService::class.java)
  }

  override val photoRepository: PhotoRepository by lazy {
    PhotoRepositoryImpl(networkService)
  }
}