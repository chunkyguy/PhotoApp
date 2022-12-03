// Copyright © 2022 whackylabs. All rights reserved.

import Foundation
import SwiftUI

@MainActor
class AppController: ObservableObject {
  private let networkController = NetworkController()

  @Published var photos: [Photo] = []
  @Published var isFetching = false

  func fetchPhotoList() async {
    isFetching = true
    do {
      photos = try await networkController.photoList
    } catch let error {
      print("error: \(error)")
    }
    isFetching = false
  }
}
