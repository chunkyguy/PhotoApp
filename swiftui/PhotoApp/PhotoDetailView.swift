// Copyright © 2022 whackylabs. All rights reserved.

import SwiftUI

struct PhotoDetailView: View {
  let photo: Photo
  
  var body: some View {
    VStack {
      AsyncImage(url: URL(string: photo.url)) { image in
        image
          .resizable()
          .scaledToFit()
      } placeholder: {
        ProgressView()
      }

      Text(photo.title)
        .multilineTextAlignment(.leading)

      Spacer()
    }
  }
}

#Preview {
  PhotoDetailView(photo: Photo.preview)
}
