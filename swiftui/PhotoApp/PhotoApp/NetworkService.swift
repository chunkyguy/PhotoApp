// Copyright © 2022 whackylabs. All rights reserved.

import Foundation

enum Resolution {
  case thumb
  case full
}

struct Photo: Codable, Identifiable {
  let id: Int
  let title: String
  let url: String
  let thumbnailUrl: String
}

class PhotoProvider {
  var photListURL: URL? {
    return URL(string: "https://jsonplaceholder.typicode.com/photos")
  }

  func imageURL(for photo: Photo, resolution: Resolution) -> URL? {
    let urlString: String = {
      switch resolution {
      case .thumb: return photo.thumbnailUrl
      case .full: return photo.url
      }
    }()
    return URL(string: urlString)
  }

  func photoList(data: Data) throws -> [Photo] {
    return try JSONDecoder().decode([Photo].self, from: data)
  }
}

enum PhotoError: Error {
  case invalidURL
}

struct NetworkService {

  private let provider: PhotoProvider

  init(provider: PhotoProvider) {
    self.provider = provider
  }

  private func getData(requestURL: URL) async throws -> Data {
      let (data, _) = try await URLSession.shared.data(for: URLRequest(url: requestURL))
      return data
  }
}

extension NetworkService {
  func getPhotoList() async throws -> [Photo] {
    guard let url = provider.photListURL else {
      throw PhotoError.invalidURL
    }

    let data = try await getData(requestURL: url)
    return try provider.photoList(data: data)
  }

  func getImage(photo: Photo, resolution: Resolution) async throws -> Data {
    guard let url = provider.imageURL(for: photo, resolution: resolution) else {
      throw PhotoError.invalidURL
    }
    return try await getData(requestURL: url)
  }
}

