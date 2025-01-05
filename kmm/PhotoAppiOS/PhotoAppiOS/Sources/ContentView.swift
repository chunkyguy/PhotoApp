import SwiftUI
import PhotoKit

struct ContentView: View {
  
  @State var photos: [Photo] = []
  
  let columns = [
    GridItem(.flexible(), alignment: .trailing),
    GridItem(.flexible(), alignment: .leading),
  ]
  
  var body: some View {
    NavigationStack {
      PhotoGridView(photos)
        .navigationTitle("Photos")
        .navigationDestination(for: Photo.self) { photo in
          PhotoCardView(
            photoUrl: photo.url,
            photoTitle: photo.title
          )
        }
    }
    .task {
      do {
        self.photos = try await NetworkService().photos()
      } catch {
        self.photos = []
      }
    }
  }
}
