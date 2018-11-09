//
//  Photo.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

import Foundation

struct Photo: Codable {
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
