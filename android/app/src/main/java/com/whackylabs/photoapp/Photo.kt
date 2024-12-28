package com.whackylabs.photoapp

import java.io.Serializable

//import kotlinx.serialization.Serializable

data class Photo(
    val albumId: Int?,
    val id: Int?,
    val title: String?,
    val url: String?,
    val thumbnailUrl: String?
) : Serializable
