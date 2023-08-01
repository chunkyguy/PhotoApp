package com.whackylabs.photoapp

import androidx.annotation.DrawableRes

data class Photo(
    @DrawableRes val imageRes: Int,
    val text: String
)
