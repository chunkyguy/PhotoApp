// Copyright © 2022 whackylabs. All rights reserved.

import Foundation
import SwiftUI

@MainActor
class AppController: ObservableObject {
    
  enum State {
    case loading
    case error
    case data([Photo])
  }
    
  @Published var state: State = .loading
  private let networkService: NetworkService
  
  init(networkService: NetworkService = NetworkServices.instance) {
    self.networkService = networkService
  }

  func fetchPhotoList() async {
    state = .loading
    do {
      state = .data(try await networkService.photoList)
    } catch let error {
      print("error: \(error)")
      state = .error
    }
  }
}

extension AppController {
  static var preview: AppController {
    AppController(networkService: NetworkServices.preview)
  }
}
