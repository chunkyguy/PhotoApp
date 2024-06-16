package com.whackylabs.photoapp

import retrofit2.http.GET

interface NetworkService {
  @GET("photos")
  suspend fun getPhotos(): List<Photo>
}
