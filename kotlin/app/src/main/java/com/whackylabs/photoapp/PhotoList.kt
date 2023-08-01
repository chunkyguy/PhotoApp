package com.whackylabs.photoapp

class PhotoList() {
    fun loadPhotos(): List<Photo> {
        return listOf<Photo>(
            Photo(R.drawable.image1, "Photo 01"),
            Photo(R.drawable.image2, "Photo 02"),
            Photo(R.drawable.image3, "Photo 03"),
            Photo(R.drawable.image4, "Photo 04"),
            Photo(R.drawable.image5, "Photo 05"),
            Photo(R.drawable.image6, "Photo 06"),
            Photo(R.drawable.image7, "Photo 07"),
            Photo(R.drawable.image8, "Photo 08"),
            Photo(R.drawable.image9, "Photo 09"),
            Photo(R.drawable.image10, "Photo 10")
        )
    }
}
