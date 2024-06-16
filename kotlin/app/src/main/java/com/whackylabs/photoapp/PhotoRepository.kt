package com.whackylabs.photoapp

interface PhotoRepository {
  suspend fun getPhotos(): List<Photo>
}

class PhotoRepositoryImpl(private val networkService: NetworkService) : PhotoRepository {
  override suspend fun getPhotos(): List<Photo> {
    return networkService.getPhotos()
  }
}