package com.whackylabs.photoapp

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform