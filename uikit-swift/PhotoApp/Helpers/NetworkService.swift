//
//  NetworkService.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

import Foundation
import UIKit

enum Resolution {
  case thumb
  case full
}

protocol PhotoProvider: AnyObject {
  var photListURL: URL? { get }
  func imageURL(for photo: Photo, resolution: Resolution) -> URL?
  func photoList(data: Data) -> [Photo]?
  
}

struct JSONPlaceholderPhoto: Photo, Codable {
  let id: Int
  let title: String
  let url: String
  let thumbnailUrl: String
}

class JSONPlaceholderPhotoProvider {
}

extension JSONPlaceholderPhotoProvider: PhotoProvider {
  var photListURL: URL? {
    return URL(string: "https://jsonplaceholder.typicode.com/photos")
  }
  
  func imageURL(for photo: Photo, resolution: Resolution) -> URL? {
    guard let jsonPhoto = photo as? JSONPlaceholderPhoto else {
      assertionFailure("Invalid photo")
      return nil
    }
    
    let urlString: String = {
      switch resolution {
      case .thumb: return jsonPhoto.thumbnailUrl
      case .full: return jsonPhoto.url
      }
    }()
    
    return URL(string: urlString)
  }
  
  func photoList(data: Data) -> [Photo]? {
    do {
      let photos = try JSONDecoder().decode([JSONPlaceholderPhoto].self, from: data)
      return photos
    } catch {
      return nil
    }
  }
}

protocol NetworkServiceType {
  func getPhotoList(completion: @escaping ([Photo]?) -> Void)
  func getImage(photo: Photo, resolution: Resolution, completion: @escaping (Data?) -> Void)
}


struct NetworkService {
  
  private let provider: PhotoProvider
  
  init(provider: PhotoProvider) {
    self.provider = provider
  }
  
  private func getData(requestURL: URL, completion: @escaping (Data?) -> Void) {
    
    let responseHandler: (Data?, URLResponse?, Error?) -> Void = { data, _, _ in completion(data) }
    
    URLSession(configuration: .default)
      .dataTask(with: requestURL, completionHandler: responseHandler)
      .resume()
  }
}

extension NetworkService: NetworkServiceType {
  func getPhotoList(completion: @escaping ([Photo]?) -> Void) {
    
    guard let url = provider.photListURL else {
      // error
      completion(nil)
      return
    }
    
    getData(requestURL: url) { [weak provider] data in
      guard
        let data = data,
        let photoList = provider?.photoList(data: data)
      else {
        // error
        completion(nil)
        return
      }
      
      completion(photoList)
    }
  }
  
  
  func getImage(photo: Photo, resolution: Resolution, completion: @escaping (Data?) -> Void) {
    guard let url = provider.imageURL(for: photo, resolution: resolution) else {
      // error
      completion(nil)
      return
    }
    
    getData(requestURL: url, completion: completion)
  }
}
