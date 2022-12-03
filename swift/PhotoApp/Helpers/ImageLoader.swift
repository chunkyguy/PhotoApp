//
//  ImageLoader.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

import UIKit

class ImageLoader {
  
  static let placeholder = UIImage(named: "placeholder")
  
  private let networkService: NetworkServiceType
  
  init(networkService: NetworkServiceType) {
    self.networkService = networkService
  }
  
  func loadImage(photo: Photo, resolution: Resolution, completion: @escaping (UIImage?) -> Void) {
    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
      
      guard let networkService = self?.networkService else {
        completion(nil)
        return
      }
      
      networkService.getImage(photo: photo, resolution: resolution) {  imageData in
        DispatchQueue.main.async {
          completion(imageData.flatMap(UIImage.init))
        }
      }
    }
  }
}

