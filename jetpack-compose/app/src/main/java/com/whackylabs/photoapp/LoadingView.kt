import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.size
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp
import com.whackylabs.photoapp.R

@Composable
fun LoadingView(modifier: Modifier = Modifier) {
  Image(
    modifier = modifier.size(200.dp),
    painter = painterResource(id = R.drawable.loading_img),
    contentDescription = "Loading"
  )
}
