//
//  PhotoViewModel.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

import UIKit

class PhotoViewModel {
    init() {}
}

extension PhotoViewModel: ListItemViewModelType {
    var details: DetailViewModelType {
        return self
    }

    var image: UIImage {
        return UIImage.make(with: .red)
    }

    func loadImage(completion: @escaping (Bool) -> Void) {}
}

extension PhotoViewModel: DetailViewModelType {
    var header: String {
        return "Details"
    }

    var title: String {
        return "Get this"
    }
}

