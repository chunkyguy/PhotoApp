//
//  AsyncImageView.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 04/12/2022.
//

import Foundation
import UIKit
import Combine

class AsyncImageView: UIView {
  private let networkController = NetworkController()
  private let imageVw: UIImageView!
  
  required init?(coder: NSCoder) { fatalError() }
  
  init(frame: CGRect, photoURL: URL) {
    super.init(frame: frame)
    
    imageVw = UIImageView(frame: self.bounds)
    addSubview(imageVw)
    
    Task.detached {
      guard let image = await self.networkController.fetchPhoto(forURL: photoURL) else {
        print("no photo")
        return
      }
      await self.setImage(image)
    }
  }
  
  @MainActor
  private func setImage(_ img: UIImage) {
    imageVw.image = img
  }
}
