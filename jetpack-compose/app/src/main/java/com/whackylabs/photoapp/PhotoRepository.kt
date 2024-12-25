package com.whackylabs.photoapp

interface PhotoRepository {
  suspend fun getPhotos(): List<Photo>
  suspend fun getPhoto(id: String): Photo?
}

class PhotoRepositoryImpl(private val networkService: NetworkService) : PhotoRepository {
  var photos: List<Photo> = listOf()

  suspend fun getData(): List<Photo> {
    if (photos.isNotEmpty()) {
      return photos
    }
    photos = networkService.getPhotos()
    return photos
  }

  override suspend fun getPhotos(): List<Photo> {
    return getData()
  }

  override suspend fun getPhoto(id: String): Photo? {
    return getData().find { it.id.toString() == id }
  }
}