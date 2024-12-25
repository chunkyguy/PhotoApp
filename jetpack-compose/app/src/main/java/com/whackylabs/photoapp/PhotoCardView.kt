import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp
import coil.compose.AsyncImage
import coil.request.ImageRequest
import com.whackylabs.photoapp.R

@Composable
fun PhotoCardView(
  photoUrl: String,
  photoTitle: String,
  modifier: Modifier = Modifier
) {
  Card(
    modifier = modifier,
    shape = MaterialTheme.shapes.medium,
    elevation = CardDefaults.cardElevation(defaultElevation = 8.dp)
  ) {
    AsyncImage(
      model = ImageRequest.Builder(context = LocalContext.current).data(photoUrl)
        .crossfade(true).build(),
      contentDescription = photoTitle,
      error = painterResource(id = R.drawable.ic_broken_image),
      placeholder = painterResource(id = R.drawable.loading_img),
      contentScale = ContentScale.Crop,
      modifier = Modifier.fillMaxWidth(),
    )
  }
}
