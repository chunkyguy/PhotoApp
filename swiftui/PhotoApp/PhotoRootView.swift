// Copyright © 2022 whackylabs. All rights reserved.

import SwiftUI

struct PhotoRootView: View {

  @StateObject var controller = AppController()

  var body: some View {
    NavigationStack {
      PhotoContentView(controller.state) {
        Task {
          await controller.fetchPhotoList()
        }
      }
      .navigationTitle("Photos")
      .navigationDestination(for: Photo.self) { photo in
        PhotoDetailView(photo: photo)
      }
    }
    .task {
      await controller.fetchPhotoList()
    }
  }
}

#Preview {
  PhotoRootView(controller: AppController.preview)
}
