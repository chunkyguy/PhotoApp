package com.whackylabs.photoapp

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.Image
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.whackylabs.photoapp.ui.theme.PhotoAppTheme

class LemonadeActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            PhotoAppTheme {
                LemonadeApp()
            }
        }
    }
}

@Composable
fun LemonadeApp() {
    Surface(
        modifier = Modifier.fillMaxSize(),
        color = MaterialTheme.colors.background
    ) {
        LemonadeContent()
    }
}

@Composable
fun LemonadeContent() {
    var currSelection = remember { mutableStateOf(0) }
    val textIds = arrayOf(
        R.string.lemon_step_01,
        R.string.lemon_step_02,
        R.string.lemon_step_03,
        R.string.lemon_step_04
    )
    val imageIds = arrayOf(
        R.drawable.lemon_tree,
        R.drawable.lemon_squeeze,
        R.drawable.lemon_drink,
        R.drawable.lemon_restart
    )
    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center,
        modifier = Modifier
            .fillMaxSize()
    ) {
        Text(
            text = stringResource(id = textIds[currSelection.value]),
            fontSize = 18.sp
        )
        Spacer(modifier = Modifier.height(16.dp))
        Image(
            painter = painterResource(id = imageIds[currSelection.value]),
            contentDescription = "",
            modifier = Modifier
                .wrapContentSize()
                .border(
                    BorderStroke(width = 2.dp, color = Color.Magenta),
                    shape = RoundedCornerShape(size = 4.dp)
                )
                .clickable {
                    currSelection.value = (currSelection.value + 1) % textIds.size
                }
        )
    }
}

@Preview
@Composable
fun LemonadePreview() {
    PhotoAppTheme {
        LemonadeApp()
    }
}