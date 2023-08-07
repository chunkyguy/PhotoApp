// Copyright © 2022 whackylabs. All rights reserved.

import Foundation

struct Photo: Codable, Identifiable {
  let id: Int
  let title: String
  let url: String
  let thumbnailUrl: String
}

extension Photo {
  private static func fileURL(_ filename: String, _ extn: String) -> String {
    let url = Bundle.main.url(forResource: filename, withExtension: extn)
    return url?.absoluteString ?? "\(filename).\(extn)"
  }
  
  static var previewPhoto: Photo {
    return Photo(
      id: 0,
      title: "Test",
      url: fileURL("full_600x600", "png"),
      thumbnailUrl: fileURL("thumb_150x150", "png")
    )
  }
  
  static var previewPhotos: [Photo] {
    return (0..<5).map {
      return Photo(
        id: $0,
        title: "Test",
        url: fileURL("full_600x600", "png"),
        thumbnailUrl: fileURL("thumb_150x150", "png")
      )
    }
  }
}
