// Copyright © 2022 whackylabs. All rights reserved.

import Foundation

class NetworkService {
  var photListURL: URL? {
    return URL(string: "https://jsonplaceholder.typicode.com/photos")
  }

  func photoList(data: Data) -> Result<[Photo], AppError> {
    do {
      let photos = try JSONDecoder().decode([Photo].self, from: data)
      return .success(photos)
    } catch {
      return .failure(.invalidData)
    }
  }
}
