package com.whackylabs.photoapp

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.wrapContentWidth
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.whackylabs.photoapp.ui.theme.PhotoAppTheme

class ComposeArticleActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            PhotoAppTheme() {
                Surface(color = MaterialTheme.colors.background) {
                    ComposeArticle()
                }
            }
        }
    }
}

// Task 02: Compose Article
@Composable
fun ComposeArticle() {
    Column {
        HeaderImage()
        HeaderText()
        ParagraphText(text = stringResource(R.string.main_content_para_01))
        ParagraphText(text = stringResource(id = R.string.main_content_para_02))
    }
}

@Composable
fun HeaderImage() {
    val img = painterResource(id = R.drawable.bg_compose_background)
    Image(painter = img, contentDescription = null, modifier = Modifier.fillMaxWidth())
}

@Composable
fun HeaderText() {
    Text(
        text = stringResource(id = R.string.main_content_title),
        fontSize = 24.sp,
        modifier = Modifier
            .fillMaxWidth()
            .wrapContentWidth(Alignment.Start)
            .padding(start = 16.dp, bottom = 16.dp, top = 16.dp, end = 16.dp)
    )
}

@Composable
fun ParagraphText(text: String) {
    Text(
        text = text,
        textAlign = TextAlign.Justify, // make text center horizontal
        modifier = Modifier
            .fillMaxWidth()
            .padding(start = 16.dp, bottom = 16.dp, top = 16.dp, end = 16.dp)
    )
}


@Preview()
@Composable
fun ComposeArticlePreview() {
    PhotoAppTheme() {
        Surface(color = MaterialTheme.colors.background) {
            ComposeArticle()
        }
    }
}
