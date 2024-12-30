package com.whackylabs.photoapp

import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.engine.android.Android
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.request.get
import io.ktor.serialization.kotlinx.json.json

class NetworkService {
    private val client = HttpClient(Android) {
        install(ContentNegotiation) { json() }
    }

    suspend fun photos(): List<Photo> {
        return client
            .get("https://jsonplaceholder.typicode.com/photos")
            .body()
    }
}