//
//  ViewController.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 03/12/2022.
//

import UIKit
import WLKit

class ViewController: UIViewController, ViewEventHandler {
  private let controller = AppController()
  private lazy var contentVw = AsyncView(viewModel: .loading, eventHandler: self)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    VFL(view)
      .add(subview: contentVw, name: "contentVw")
      .applyConstraints(formats: [
        "H:|[contentVw]|", "V:|[contentVw]|"
      ])
    
    Task.detached { await self.reloadPhotos() }
  }
  
  @MainActor
  private func reloadPhotos() async {
    contentVw.viewModel = .loading
    let photos = await controller.fetchPhotos()
    switch photos {
    case .success(let photos):
      let photoListVw = PhotoListView(
        viewModel: PhotoListViewModel(title: "Photos", photos: photos),
        eventHandler: self,
        controller: controller
      )
      contentVw.viewModel = .success(photoListVw)
    case .failure(let err):
      contentVw.viewModel = .error(err)
    }
  }
  
  func handle(event: ViewEvent, sender: OSView?) {
    guard let event = event as? AppViewEvent else {
      assertionFailure("Unrecognized event \(event)")
      return
    }
    
    switch event {
    case .retry:
      Task.detached { await self.reloadPhotos() }
    case .showDetails(let photo):
      let photoVwCtrl = PhotoViewController(photo: photo, controller: controller)
      present(photoVwCtrl, animated: true)
    }
  }
}
