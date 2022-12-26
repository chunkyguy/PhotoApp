// Copyright © 2022 whackylabs. All rights reserved.

import Foundation
import UIKit

struct NetworkController {

  private let service: NetworkService

  init(service: NetworkService = NetworkService()) {
    self.service = service
  }
  
  func fetchPhotos() async -> Result<[Photo], NetworkError> {
    guard let url = service.photListURL else {
      return .failure(.invalidURL)
    }

    let data = await data(requestURL: url)
    return data.flatMap { service.photoList(data: $0) }
  }
  
  func fetchPhoto(forURL url: URL) async -> UIImage? {
    let data = await data(requestURL: url)
    guard case .success(let photoData) = data else {
      return nil
    }
    return UIImage(data: $0)
  }

  private func data(requestURL: URL) async -> Result<Data, NetworkError> {
    do {
      let (data, _) = try await URLSession.shared.data(for: URLRequest(url: requestURL))
      return .success(data)
    } catch {
      return .failure(.badNetwork)
    }
  }
}

