//
//  ImageLoader.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

import UIKit

struct ImageLoader {

    static let placeholder = UIImage(named: "placeholder")

    enum Resolution {
        case thumb
        case full
    }

    static func loadImage(photo: Photo, resolution: Resolution, completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = photo.imageURL(resolution: resolution) else {
            completion(nil)
            return
        }

        DispatchQueue.global(qos: .userInitiated).async {
            NetworkService.getPhoto(url: imageURL) {  image in
                DispatchQueue.main.async { completion(image) }
            }
        }
    }
}

fileprivate extension Photo {
    func imageURL(resolution: ImageLoader.Resolution) -> URL? {
        let urlString: String = {
            switch resolution {
            case .thumb: return thumbnailUrl
            case .full: return url
            }
        }()

        return URL(string: urlString)
    }
}
