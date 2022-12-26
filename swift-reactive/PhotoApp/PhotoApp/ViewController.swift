//
//  ViewController.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 03/12/2022.
//

import UIKit
import SimpleLayoutEngine

class ViewController: SLEViewController {
  
  private let networkController = NetworkController()
  private let loadingVw = UIActivityIndicatorView(style: .large)
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func addViews(frame: CGRect) {
    super.addViews(frame: frame)
    
    view.backgroundColor = .white
    
    loadingVw.hidesWhenStopped = true
    loadingVw.center = CGPoint(x: frame.width/2, y: frame.height/2)
    view.addSubview(loadingVw)
    
    reloadPhotos()
  }
  
  override func updateViews(frame: CGRect) {
    super.updateViews(frame: frame)
  }
  
  private func reloadPhotos() {
    loadingVw.startAnimating()
    Task.detached {
      let photos = await self.networkController.fetchPhotos()
      switch photos {
      case .success(let photos):
        await self.loadPhotos(photos)
        
      case .failure(let err):
        await self.loadError(err)
      }
    }
  }
  
  @MainActor
  private func loadPhotos(_ photos: [Photo]) {
    loadingVw.stopAnimating()
  }
  
  @MainActor
  private func loadError(_ error: NetworkError) {
    print("\(error)")
  }
}
