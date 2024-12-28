//
//  LoadingView.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 02/08/2023.
//

import UIKit
import WLKit

class LoadingView: View<Bool> {
  private let loadingVw = UIActivityIndicatorView(style: .large)

  override func setUp() {
    super.setUp()
    VFL(self)
      .add(subview: loadingVw, name: "loadingVw")
      .applyConstraints(constraints: [
        loadingVw.centerXAnchor.constraint(equalTo: centerXAnchor),
        loadingVw.centerYAnchor.constraint(equalTo: centerYAnchor)
      ])
    loadingVw.hidesWhenStopped = true
    loadingVw.tintColor = UIColor.black
  }
  
  override func viewModelDidUpdate() {
    super.viewModelDidUpdate()
    if viewModel {
      loadingVw.startAnimating()
    } else {
      loadingVw.stopAnimating()
    }
  }
}
