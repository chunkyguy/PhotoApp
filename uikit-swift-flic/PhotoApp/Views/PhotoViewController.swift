//
//  PhotoViewController.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 03/08/2023.
//

import UIKit
import WLKit

class PhotoViewController: UIViewController, ViewEventHandler {
  private let controller: AppController
  private let photo: Photo
  
  init(photo: Photo, controller: AppController) {
    self.photo = photo
    self.controller = controller
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let photoVw = PhotoView(viewModel: photo.url, eventHandler: self, controller: controller)
    VFL(view)
      .add(subview: photoVw, name: "photoVw")
      .applyConstraints(formats: [
        "H:|[photoVw]|",
        "V:|[photoVw]|"
      ])
  }
  
  func handle(event: ViewEvent, sender: OSView?) {
    assertionFailure()
  }
}
