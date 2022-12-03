//
//  PhotoDetailViewModel.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

import UIKit

class PhotoDetailViewModel {
  private let photo: Photo
  private(set) var image: UIImage
  private let imageLoader: ImageLoader
  
  init(photo: Photo, thumb: UIImage, imageLoader: ImageLoader) {
    self.photo = photo
    self.image = thumb
    self.imageLoader = imageLoader
  }
}

extension PhotoDetailViewModel: DetailViewModelType {
  var title: String {
    return photo.title
  }
}

extension PhotoDetailViewModel: ImageProvider {
  func loadImage(completion: @escaping (Bool) -> Void) {
    imageLoader.loadImage(photo: photo, resolution: .full) { [weak self] image in
      guard let image = image else {
        completion(false)
        return
      }
      
      self?.image = image
      completion(true)
    }
  }
}
