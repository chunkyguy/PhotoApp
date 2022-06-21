// Copyright © 2022 whackylabs. All rights reserved.

import Foundation

enum PhotoError: Error {
  case invalidURL
}

struct NetworkController {

  var photoList: [Photo] {
    get async throws {
      guard let url = service.photListURL else {
        throw PhotoError.invalidURL
      }

      let data = try await data(requestURL: url)
      return try service.photoList(data: data)
    }
  }

  private let service: NetworkService

  init(service: NetworkService = NetworkService()) {
    self.service = service
  }

  private func data(requestURL: URL) async throws -> Data {
    let (data, _) = try await URLSession.shared.data(for: URLRequest(url: requestURL))
    return data
  }
}

