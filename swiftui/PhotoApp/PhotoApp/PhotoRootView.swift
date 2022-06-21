// Copyright © 2022 whackylabs. All rights reserved.

import SwiftUI

struct PhotoRootView: View {

  @StateObject var controller = AppController()

  var body: some View {
    NavigationView {
      PhotoListView(photos: controller.photos)
        .navigationTitle("Photos")
    }
    .task {
      await controller.fetchPhotoList()
    }
  }
}
