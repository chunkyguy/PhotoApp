// Copyright © 2022 whackylabs. All rights reserved.

import SwiftUI

struct PhotoTileView: View {
  let photo: Photo

  var body: some View {
    AsyncImage(url: URL(string: photo.thumbnailUrl)) { image in
      image
        .resizable()
        .scaledToFit()
    } placeholder: {
      ProgressView()
    }
  }
}

struct PhotoTileView_Preview: PreviewProvider {
  static var previews: some View {
    PhotoTileView(photo: Photo.previewPhoto)
  }
}
