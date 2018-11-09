//
//  PhotoListViewModel.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

import Foundation

class PhotoListViewModel {
    private var photoList: [Photo] = []
}

extension PhotoListViewModel: ListViewModelType {
    var title: String {
        return "Photos"
    }

    var items: [ListItemViewModelType] {
        return photoList.map(PhotoViewModel.init)
    }

    func loadPhotoList(completion: @escaping (Bool) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            NetworkService.getPhotoList { [weak self] photoList in
                guard let photoList = photoList else {
                    DispatchQueue.main.async { completion(false) }
                    return
                }
                self?.photoList = photoList
                DispatchQueue.main.async { completion(true) }
            }
        }
    }

}
