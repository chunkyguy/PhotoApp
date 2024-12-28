//
//  PhotoListView.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 05/12/2022.
//

import Foundation
import UIKit
import WLKit

struct PhotoListViewModel {
  var title: String
  var photos: [Photo]
}

class PhotoListView: View<PhotoListViewModel> {
  private static let cellId = "photo-list-cell"
  private static let headerId = "photo-list-header"
  
  private let controller: AppController
  
  init(
    viewModel: PhotoListViewModel,
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
  
  private let collectionVw = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  )

  override func setUp() {
    super.setUp()

    VFL(self)
      .add(subview: collectionVw, name: "collectionVw")
      .applyConstraints(formats: [
        "H:|[collectionVw]|", "V:|[collectionVw]|"
      ])
    
    collectionVw.register(CollectionCell.self, forCellWithReuseIdentifier: Self.cellId)
    collectionVw.register(
      CollectionReusableView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: Self.headerId
    )

    backgroundColor = .black
    collectionVw.backgroundColor = .black
    collectionVw.dataSource = self
    collectionVw.delegate = self
  }
  
  override func viewModelDidUpdate() {
    super.viewModelDidUpdate()
    collectionVw.reloadData()
  }
}

extension PhotoListView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.cellId, for: indexPath)
    if let collectionCell = cell as? CollectionCell {
      collectionCell.view = PhotoView(
        viewModel: viewModel.photos[indexPath.item].thumbnailUrl,
        eventHandler: eventHandler,
        controller: controller
      )
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Self.headerId, for: indexPath)
      if let headerView = supplementaryView as? CollectionReusableView {
        headerView.view = TitleView(viewModel.title)
      }
      return supplementaryView
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension PhotoListView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: collectionView.bounds.width/2.0, height: 200
      )
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 128)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
}

extension PhotoListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      assert(eventHandler != nil)
      eventHandler?.handle(event: AppViewEvent.showDetails(viewModel.photos[indexPath.item]), sender: self)
    }
}

extension PhotoListView {
  class TitleView: View<String> {
    override func setUp() {
      super.setUp()
      let titleLabel = UILabel()
      VFL(self)
        .add(subview: titleLabel, name: "titleLabel")
        .applyConstraints(formats: ["V:[titleLabel]-|", "H:|-[titleLabel]|"])
      
      titleLabel.backgroundColor = .black
      titleLabel.font = UIFont.boldSystemFont(ofSize: 48)
      titleLabel.textColor = .white
      titleLabel.text = viewModel
    }
  }
}
