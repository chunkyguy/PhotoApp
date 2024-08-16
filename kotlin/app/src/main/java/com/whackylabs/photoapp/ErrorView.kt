import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp
import com.whackylabs.photoapp.R

@Composable
fun ErrorView(onClick: () -> Unit, modifier: Modifier = Modifier) {
  Column(
    modifier = modifier,
    verticalArrangement = Arrangement.Center,
    horizontalAlignment = Alignment.CenterHorizontally,
  ) {
    Image(
      painter = painterResource(id = R.drawable.ic_connection_error),
      contentDescription = "Error",
    )
    Text(text = "Error. Please try again", modifier = Modifier.padding(16.dp))
    Button(onClick = { onClick() }) {
      Text(text = "Retry")
    }
  }
}
