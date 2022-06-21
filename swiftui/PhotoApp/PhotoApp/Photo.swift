// Copyright © 2022 whackylabs. All rights reserved.

import Foundation

struct Photo: Codable, Identifiable {
  let id: Int
  let title: String
  let url: String
  let thumbnailUrl: String
}
