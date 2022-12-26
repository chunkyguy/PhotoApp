//
//  PhotoListView.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 05/12/2022.
//

import Foundation
import UIKit
import Combine

class PhotoListView: UIView {
  static private let cellId = "photo-list-view"
  
  private var cancellable: Cancellable?
  private var listVw: UICollectionView!
  
  private var photos: [Photo] = [] {
    didSet {
      listVw.reloadData()
    }
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  init(frame: CGRect, photos: AnyPublisher<[Photo], Never>) {
    super.init(frame: frame)
    self.listVw = UICollectionView(frame: bounds, collectionViewLayout: UICollectionViewFlowLayout())
    listVw.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Self.cellId)
    addSubview(listVw)
    
    cancellable = photos.receive(on: DispatchQueue.main).assign(to: \.photos, on: self)
//    photos.receive(on: DispatchQueue.main).sink { photos = $0 }
  }
}

extension PhotoListView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.cellId, for: indexPath)
    return cell
  }
}
