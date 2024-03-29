//
//  Extensions.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

import UIKit

extension UIView {
  func add(subviews: [UIView]) {
    subviews.forEach(addSubview)
    subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
  }
  
  func add(visualConstraints: [String], viewsDict: [String: Any]) {
    visualConstraints
      .map { NSLayoutConstraint.constraints(withVisualFormat: $0, options: [], metrics: nil, views: viewsDict) }
      .forEach { addConstraints($0) }
    
  }
}

extension UIImage {
  static func make(with color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
    let rect = CGRect(origin: CGPoint.zero, size: size)
    UIGraphicsBeginImageContext(rect.size)
    defer { UIGraphicsEndImageContext() }
    
    guard let context = UIGraphicsGetCurrentContext() else {
      return UIImage()
    }
    
    context.setFillColor(color.cgColor)
    context.fill(rect)
    guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
      return UIImage()
    }
    return image
  }
}

extension String {
  func size(font: UIFont, maxSize: CGSize) -> CGSize {
    let attributes: [NSAttributedString.Key: Any] = [.font: font]
    return self.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size
  }
  
  func height(font: UIFont, width: CGFloat) -> CGFloat {
    return ceil(size(font: font, maxSize: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)).height)
  }
}

struct SizeUtility {
  static func aspectCorrectSize(width: CGFloat, aspectSize: CGSize) -> CGSize {
    let height = aspectSize.height * (width/aspectSize.width)
    return CGSize(width: width, height: height)
  }
}
