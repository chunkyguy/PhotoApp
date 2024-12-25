//
//  PhotoListViewModel.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

import Foundation

class PhotoListViewModel {
  private let imageLoader: ImageLoader
  private let networkService: NetworkServiceType
  private var photoList: [Photo] = []
  
  init(networkService: NetworkServiceType, imageLoader: ImageLoader) {
    self.networkService = networkService
    self.imageLoader = imageLoader
  }
}

extension PhotoListViewModel: ListViewModelType {
  var title: String {
    return "Photos"
  }
  
  var items: [ListItemViewModelType] {
    return photoList.map {
      PhotoViewModel(photo: $0, imageLoader: imageLoader)
    }
  }
  
  func loadPhotoList(completion: @escaping (Bool) -> Void) {
    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
      
      guard let strongSelf = self else {
        completion(false)
        return
      }
      
      strongSelf.networkService.getPhotoList { [weak self] photoList in
        guard let photoList = photoList else {
          DispatchQueue.main.async { completion(false) }
          return
        }
        self?.photoList = photoList
        DispatchQueue.main.async { completion(true) }
      }
    }
  }
  
}
