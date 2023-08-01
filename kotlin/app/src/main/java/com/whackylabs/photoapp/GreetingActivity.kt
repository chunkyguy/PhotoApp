package com.whackylabs.photoapp

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.*
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.whackylabs.photoapp.ui.theme.PhotoAppTheme

class GreetingActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            PhotoAppTheme() {
                Surface(color = MaterialTheme.colors.background) {
                    BirthdayGreeting()
                }
            }
        }
    }
}

// Task 01: Birthday Message
@Composable
fun BirthdayGreeting() {
    Row() {
        GreetingWithImage(
            message = stringResource(id = R.string.birthday_message), from = stringResource(
                id = R.string.birthday_signature
            )
        )
    }
}

@Composable
fun GreetingWithImage(message: String, from: String) {
    val img = painterResource(id = R.drawable.androidparty)
    Box() {
        Image(
            painter = img,
            contentDescription = null,
            modifier = Modifier
                .fillMaxHeight()
                .fillMaxWidth(),
            contentScale = ContentScale.Crop
        )
        GreetingWithText(message = message, from = from)
    }
}

@Composable
fun GreetingWithText(message: String, from: String) {
    Column() {
        Text(
            text = message, fontSize = 36.sp, modifier = Modifier
                .fillMaxWidth()
                .wrapContentWidth(Alignment.CenterHorizontally)
                .padding(start = 16.dp, top = 16.dp)
        )
        Text(
            text = from,
            fontSize = 24.sp,
            modifier = Modifier
                .fillMaxWidth()
                .wrapContentWidth(Alignment.CenterHorizontally)
                .padding(start = 16.dp, end = 16.dp)
        )
    }
}

@Preview()
@Composable
fun GreetingPreview() {
    PhotoAppTheme() {
        Surface(color = MaterialTheme.colors.background) {
            BirthdayGreeting()
        }
    }
}