//
//  PhotoView.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 02/08/2023.
//

import UIKit
import WLKit

typealias PhotoViewModel = String

class PhotoView: View<PhotoViewModel>, ViewEventHandler {
  private let controller: AppController
  private lazy var contentVw = AsyncView(viewModel: .loading, eventHandler: self)

  init(
    viewModel: PhotoViewModel,
    eventHandler: ViewEventHandler?,
    frame: CGRect? = nil,
    controller: AppController
  ) {
    self.controller = controller
    super.init(viewModel: viewModel, eventHandler: eventHandler, frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setUp() {
    super.setUp()
    VFL(self)
      .add(subview: contentVw, name: "contentVw")
      .applyConstraints(formats: ["V:|[contentVw]|", "H:|[contentVw]|"])
    
    Task.detached { await self.reloadPhoto() }
  }
  
  @MainActor
  private func reloadPhoto() async {
    contentVw.viewModel = .loading
    let photo = await controller.fetchImage(forURL: viewModel)
    switch photo {
    case .success(let image):
      let imageVw = UIImageView(image: image)
      imageVw.contentMode = .scaleAspectFit
      contentVw.viewModel = .success(imageVw)
    case .failure(let err):
      contentVw.viewModel = .error(err)
    }
  }
  
  func handle(event: ViewEvent, sender: OSView?) {
    guard let event = event as? AppViewEvent else {
      eventHandler?.handle(event: event, sender: sender)
      return
    }
    
    switch event {
    case .retry:
      Task.detached { await self.reloadPhoto() }
    default:
      eventHandler?.handle(event: event, sender: sender)
    }
  }
}
