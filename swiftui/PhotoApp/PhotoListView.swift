// Copyright © 2022 whackylabs. All rights reserved.

import SwiftUI

struct PhotoListView: View {

  let photos: [Photo]

  let columns = [
    GridItem(.flexible(), alignment: .trailing),
    GridItem(.flexible(), alignment: .leading),
  ]

  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
        ForEach(photos) { photo in
          NavigationLink {
            PhotoDetailView(photo: photo)
          } label: {
            PhotoTileView(photo: photo)
              .frame(width: 150, height: 150)
          }
        }
      }
    }
  }
}

struct PhotoListView_Preview: PreviewProvider {
  static var previews: some View {
    PhotoListView(photos: Photo.previewPhotos)
  }
}
