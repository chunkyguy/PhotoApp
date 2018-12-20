//
//  DetailViewController.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

import UIKit

protocol DetailViewModelType: ImageProvider {
    var title: String { get }
}

/// Renders photo details
class DetailViewController: UIViewController {

    private let viewModel: DetailViewModelType

    @IBOutlet weak var collectionView: UICollectionView!

    init(viewModel: DetailViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()


        title = "Details"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(onCancel))

        collectionView.register(
            ImageCollectionViewCell.self,
            forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier
        )
        collectionView.register(
            TextCollectionViewCell.self,
            forCellWithReuseIdentifier: TextCollectionViewCell.reuseIdentifier
        )

        collectionView.dataSource = self
        collectionView.delegate = self

        view.backgroundColor = .black
        collectionView.backgroundColor = .black
    }

   @objc func onCancel() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: UICollectionViewDataSource
extension DetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath)
            return configureImage(cell: cell)

        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCollectionViewCell.reuseIdentifier, for: indexPath)
            return configure(
                cell: cell,
                text: viewModel.title
            )

        default:
            assertionFailure("Invalid item")
            return UICollectionViewCell()
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.item {
        case 0:
            return SizeUtility.aspectCorrectSize(
                width: collectionView.bounds.width,
                aspectSize: viewModel.image.size
            )

        case 1:
            let width = collectionView.bounds.width
            let height = viewModel.title.height(
                font: TextCollectionViewCell.font,
                width: width - 16.0
            )
            return CGSize(width: width, height: height)

        default: return .zero
        }
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
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
}

extension DetailViewController {

    private func configureImage(cell: UICollectionViewCell) -> UICollectionViewCell {
        guard let imageCell = cell as? ImageCollectionViewCell else {
            return cell
        }

        imageCell.set(viewModel: viewModel)
        return imageCell
    }

    private func configure(cell: UICollectionViewCell, text: String) -> UICollectionViewCell {
        guard let textCell = cell as? TextCollectionViewCell else {
            return cell
        }

        textCell.set(text: text)
        return textCell
    }
}
