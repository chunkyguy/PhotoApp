//
//  ImageCollectionViewCell.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "PosterCollectionViewCell"

    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    private func setUp() {
        contentView.add(subviews: [imageView])
        contentView.add(visualConstraints: ["V:|[I]|", "H:|[I]|"], viewsDict: ["I": imageView])
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        // TODO: set placeholder image
        // imageView.image = ...
        imageView.contentMode = .scaleAspectFill
    }

    func set(viewModel: ListItemViewModelType) {
        imageView.image = viewModel.image
        viewModel.loadImage { [weak self] isGood in
            guard isGood else {
                // TOOD: render error
                return
            }

            self?.imageView.image = viewModel.image
        }
    }
}
