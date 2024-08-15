// Copyright © 2022 whackylabs. All rights reserved.

import Foundation

enum PhotoError: Error {
  case invalidURL
}

protocol NetworkService {
  var photoList: [Photo] { get async throws }
}

private class NetworkServiceImpl: NetworkService {
  
  var photoList: [Photo] {
    get async throws {
      guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
        throw PhotoError.invalidURL
      }

      let data = try await data(requestURL: url)
      return try JSONDecoder().decode([Photo].self, from: data)
    }
  }
  
  private func data(requestURL: URL) async throws -> Data {
    let (data, _) = try await URLSession.shared.data(for: URLRequest(url: requestURL))
    return data
  }
}

private class PreviewNetworkService: NetworkService {
  var photoList: [Photo] {
    get async throws {
      Photo.previews
    }
  }
}

struct NetworkServices {
  static var instance: NetworkService {
    NetworkServiceImpl()
  }
  
  static var preview: NetworkService {
    PreviewNetworkService()
  }
}
