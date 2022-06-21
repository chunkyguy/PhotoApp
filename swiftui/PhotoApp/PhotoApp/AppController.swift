// Copyright © 2022 whackylabs. All rights reserved.

import Foundation
import SwiftUI

@MainActor
class AppController: ObservableObject {
  private let networkService = NetworkService(provider: PhotoProvider())

  @Published var photos: [Photo] = []
  @Published var isFetching = false

  func getPhotoList() async {
    isFetching = true
    do {
      photos = try await networkService.getPhotoList()
    } catch let error {
      print("error: \(error)")
    }
    isFetching = false
  }
}
