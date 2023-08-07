// Copyright © 2022 whackylabs. All rights reserved.

import Foundation
import UIKit
import WLKit

enum AppError: Error {
  case invalidURL
  case badNetwork
  case invalidData
}

enum AppViewEvent: ViewEvent {
  case retry
  case showDetails(Photo)
}

struct AppController {

  private let service: NetworkService

  init(service: NetworkService = NetworkService()) {
    self.service = service
  }
  
  func fetchPhotos() async -> Result<[Photo], AppError> {
    guard let url = service.photListURL else {
      return .failure(.invalidURL)
    }

    let data = await data(requestURL: url)
    return data.flatMap { service.photoList(data: $0) }
  }
  
  func fetchImage(forURL url: String) async -> Result<UIImage, AppError> {
    guard let url = URL(string: url) else {
      return .failure(.invalidURL)
    }
    let data = await data(requestURL: url)
    guard case .success(let photoData) = data else {
      return .failure(.invalidData)
    }
    guard let image = UIImage(data: photoData) else {
      return .failure(.invalidData)
    }
    return .success(image)
  }

  private func data(requestURL: URL) async -> Result<Data, AppError> {
    do {
      let (data, _) = try await URLSession.shared.data(for: URLRequest(url: requestURL))
      return .success(data)
    } catch {
      return .failure(.badNetwork)
    }
  }
}

