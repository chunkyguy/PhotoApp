//
//  RootView.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 07/12/2022.
//

import Foundation
import UIKit
import Combine

class RootView: UIView {
  required init?(coder: NSCoder) { fatalError() }
  
  init(frame: CGRect, photos: AnyPublisher<[Photo], Error>) {
    super.init(frame: frame)
    
  }
}
