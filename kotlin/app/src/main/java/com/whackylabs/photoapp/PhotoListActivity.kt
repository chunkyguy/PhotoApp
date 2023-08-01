package com.whackylabs.photoapp

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.Card
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.whackylabs.photoapp.ui.theme.PhotoAppTheme
import androidx.compose.foundation.lazy.items
import androidx.compose.ui.layout.ContentScale

class PhotoListActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            PhotoListApp()
        }
    }
}

@Composable
fun PhotoListApp() {
    PhotoList(photos = PhotoList().loadPhotos())
}

@Composable
fun PhotoList(photos: List<Photo>) {
    LazyColumn {
        items(photos) { photo ->
            PhotoCard(photo = photo)
        }
    }

    Column() {
        photos.forEach { photo ->
            PhotoCard(photo = photo)
        }
    }
}

@Composable
fun PhotoCard(photo: Photo) {
    Card(elevation = 4.dp, modifier = Modifier.padding(8.dp)) {
        Column {
            Image(
                painter = painterResource(id = photo.imageRes),
                contentDescription = photo.text,
                contentScale = ContentScale.Crop,
                modifier = Modifier
                    .fillMaxWidth()
                    .height(194.dp)
            )
            Text(text = photo.text, style = MaterialTheme.typography.caption)
        }
    }
}

@Preview
@Composable
fun PhotoListPreivew() {
    PhotoAppTheme {
        val photo = Photo(imageRes = R.drawable.image1, "Image")
        val photos = listOf<Photo>(photo, photo)
        PhotoList(photos = photos)
    }
}