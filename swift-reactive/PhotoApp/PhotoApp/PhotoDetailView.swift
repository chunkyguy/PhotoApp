//
//  PhotoDetailView.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 04/12/2022.
//

import UIKit




class PhotoDetailView: UIView {
  required init?(coder: NSCoder) { fatalError() }
  
  init(frame: CGRect, photo: DataBinding<UIImage>) {
    super.init(frame: frame)
    
    let imageVw = UIImageView(frame: bounds)
    addSubview(imageVw)
    photo.connect { imageVw.image = $0 }
  }

}
