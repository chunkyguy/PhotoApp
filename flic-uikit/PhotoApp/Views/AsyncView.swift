//
//  AsyncView.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 01/08/2023.
//

import UIKit
import WLKit

enum AsyncViewModel {
  case loading
  case success(UIView)
  case error(AppError)
}

class AsyncView: View<AsyncViewModel>, ContentViewBindable {
  var contentView: UIView { self }
  
  override func setUp() {
    super.setUp()
    backgroundColor = .white
  }
  
  override func viewModelDidUpdate() {
    super.viewModelDidUpdate()
    switch viewModel {
    case .loading:
      self.view = LoadingView(true)
    case .success(let view):
      self.view = view
    case .error(let error):
      self.view = ErrorView(error)      
    }
  }
}

