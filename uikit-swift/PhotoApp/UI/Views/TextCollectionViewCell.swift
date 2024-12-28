//
//  TextCollectionViewCell.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

import UIKit

/// Render text
class TextCollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = "TextCollectionViewCell"
  
  static let font = UIFont.preferredFont(forTextStyle: .body)
  
  private let label = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUp()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setUp()
  }
  
  private func setUp() {
    contentView.add(subviews: [label])
    contentView.add(visualConstraints: ["V:|[L]|", "H:|-[L]-|"], viewsDict: ["L": label])
    
    label.textColor = .white
    label.numberOfLines = 0
    label.font = TextCollectionViewCell.font
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    label.text = nil
  }
  
  func set(text: String) {
    label.text = text
  }
}
