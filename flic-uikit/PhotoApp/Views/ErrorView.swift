//
//  ErrorView.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 02/08/2023.
//

import UIKit
import WLKit

class ErrorView: View<AppError> {
  override func setUp() {
    let label = UILabel()
    let button = UIButton(type: .roundedRect)
    super.setUp()
    VFL(self)
      .add(subview: label, name: "label")
      .add(subview: button, name: "button")
      .applyConstraints(formats: [
        "H:|[label]|",
        "H:[button(100)]",
        "V:[label]-16-[button(52)]"
      ])
      .appendConstraints([
        label.centerYAnchor.constraint(equalTo: centerYAnchor),
        button.centerXAnchor.constraint(equalTo: centerXAnchor)
      ])
    label.text = viewModel.localizedDescription
    label.numberOfLines = 0
    label.textAlignment = .center
    button.setTitleColor(.black, for: .normal)
    button.setTitle("Retry", for: .normal)
    button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
  }
  
  @objc func handleTap() {
    assert(eventHandler != nil)
    eventHandler?.handle(event: AppViewEvent.retry, sender: self)
  }
}
