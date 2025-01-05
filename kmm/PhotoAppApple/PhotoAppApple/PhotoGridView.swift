import SwiftUI
import shared

struct PhotoGridView: View {
  var photos: [Photo] = []
  
  init(_ photos: [Photo]) {
    self.photos = photos
  }

  let columns = [
    GridItem(.flexible(), alignment: .trailing),
    GridItem(.flexible(), alignment: .leading),
  ]

  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
        ForEach(photos, id: \.id) { photo in
          NavigationLink(value: photo) {
            PhotoCardView(photoUrl: photo.thumbnailUrl, photoTitle: nil)
              .frame(width: 150, height: 150)
          }
        }
      }
    }
  }
}
