//
//  PhotoListViewModel.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

import Foundation

struct PhotoListViewModel {

}

extension PhotoListViewModel: ListViewModelType {
    var title: String {
        return "Photos"
    }

    var items: [ListItemViewModelType] {
        return [PhotoViewModel()]
    }

    func loadPhotoList(completion: @escaping (Bool) -> Void) {}
}
