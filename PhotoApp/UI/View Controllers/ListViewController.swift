//
//  ListViewController.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

import UIKit

protocol ListItemViewModelType {
    var image: UIImage { get }
    var details: DetailViewModelType { get }
    func loadImage(completion: @escaping (Bool) -> Void)
}

protocol ListViewModelType {
    var title: String { get }
    var items: [ListItemViewModelType] { get }
    func loadPhotoList(completion: @escaping (Bool) -> Void)
}

/// Render a list of photos
class ListViewController: UIViewController {

    private let viewModel: ListViewModelType

    @IBOutlet weak var collectionView: UICollectionView!

    init(viewModel: ListViewModelType) {
        self.viewModel = viewModel

        super.init(nibName: "ListViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(
            ImageCollectionViewCell.self,
            forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier
        )
        collectionView.register(
            TitleHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TitleHeaderView.reuseIdentifier
        )

        view.backgroundColor = .black
        collectionView.backgroundColor = .black

        loadPhotoList()
    }

    private func loadPhotoList() {
        collectionView.reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension ListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier,
            for: indexPath
        )

        guard let posterCell = cell as? ImageCollectionViewCell else {
            assertionFailure("Unsupported cell type")
            return cell
        }

        posterCell.set(viewModel: viewModel.items[indexPath.item])
        return posterCell
    }


    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath) -> UICollectionReusableView {

        guard kind == UICollectionView.elementKindSectionHeader else {
            assertionFailure("Undefined kind \(kind)")
            return UICollectionReusableView()
        }

        let supplementaryView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: TitleHeaderView.reuseIdentifier,
            for: indexPath
        )

        guard let headerView = supplementaryView as? TitleHeaderView else {
            assertionFailure("Unsupported view")
            return supplementaryView
        }

        headerView.set(title: viewModel.title)

        return headerView
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // some random aspect ratio
        let aspectSize = CGSize(width: 348, height: 522)
        let width = collectionView.bounds.width/2.0
        let height = aspectSize.height * (width/aspectSize.width)
        return CGSize(width: width, height: height)
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

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let details = DetailViewController(viewModel: viewModel.items[indexPath.item].details)
        show(details, sender: nil)
    }
}
