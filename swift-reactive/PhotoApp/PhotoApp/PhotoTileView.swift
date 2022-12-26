//
//  PhotoTileView.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 04/12/2022.
//

import UIKit

class PhotoTileView: UICollectionViewCell {
  
  required init?(coder: NSCoder) { fatalError() }

  init(frame: CGRect, photo: Photo) {
    super.init(frame: frame)
    
    let aa = photo.compactMap { URL(string: $0.url) }
    
    let imageVw = AsyncImageView(frame: bounds, photoURL: <#T##URL#>)
    UIImageView(frame: bounds)
    addSubview(imageVw)
  }
}
