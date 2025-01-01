import SwiftUI
import shared

struct PhotoCardView: View {
  var photo: Photo
  
  init(_ photo: Photo) {
    self.photo = photo
  }

  var body: some View {
    AsyncImage(url: photo.thumbnailUrl.flatMap(URL.init)) { image in
      image
        .resizable()
        .scaledToFit()
    } placeholder: {
      ProgressView()
    }
  }
}

