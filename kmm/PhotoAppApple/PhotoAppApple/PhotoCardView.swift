import SwiftUI
import shared

struct PhotoCardView: View {
  var photoUrl: String?
  var photoTitle: String?
  
  var body: some View {
    VStack {
      AsyncImage(url: photoUrl.flatMap(URL.init)) { image in
        image
          .resizable()
          .scaledToFit()
      } placeholder: {
        ProgressView()
      }

      Text(photoTitle ?? "")
    }
  }
}

