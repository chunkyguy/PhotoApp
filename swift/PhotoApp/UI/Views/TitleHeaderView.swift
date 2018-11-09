//
//  TitleHeaderView.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//
import UIKit

/// Render text as header
class TitleHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "TitleHeaderView"

    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    private func setUp() {
        add(subviews: [titleLabel])
        add(visualConstraints: ["V:[L]-|", "H:|-[L]|"], viewsDict: ["L": titleLabel])

        titleLabel.backgroundColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 48)
        titleLabel.textColor = .white
    }

    func set(title: String) {
        titleLabel.text = title
    }
}
