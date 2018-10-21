//
//  PhotoViewModel.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

import UIKit

class PhotoViewModel {
    private(set) var image: UIImage = ImageLoader.placeholder ?? UIImage.make(with: .gray)
    private let photo: Photo

    init(photo: Photo) {
        self.photo = photo
    }
}

extension PhotoViewModel: ListItemViewModelType {
    var itemSize: CGSize {
        return image.size
    }

    var details: DetailViewModelType {
        return PhotoDetailViewModel(photo: photo, thumb: image)
    }
}

extension PhotoViewModel: ImageProvider {
    func loadImage(completion: @escaping (Bool) -> Void) {
        ImageLoader.loadImage(photo: photo, resolution: .thumb) { [weak self] image in
            guard let image = image else {
                completion(false)
                return
            }

            self?.image = image
            completion(true)
        }
    }
}

