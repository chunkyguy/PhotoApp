//
//  NetworkService.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

import Foundation
import UIKit

struct NetworkService {

    enum Request {
        case photoList
        case image(URL)

        var url: URL? {
            switch self {
            case .photoList: return URL(string: "https://jsonplaceholder.typicode.com/photos")
            case .image(let url): return url
            }
        }
    }

    private static func getData(request: Request, completion: @escaping (Data?) -> Void) {

        guard let url = request.url else {
            // TODO: better error handling
            completion(nil)
            return
        }

        let responseHandler: (Data?, URLResponse?, Error?) -> Void = { data, _, _ in completion(data) }

        URLSession(configuration: .default)
            .dataTask(with: url, completionHandler: responseHandler)
            .resume()
    }

    static func getPhotoList(completion: @escaping ([Photo]?) -> Void) {
        getData(request: .photoList) { data in
            guard let data = data else {
                // TODO: better error handling
                completion(nil)
                return
            }

            do {
                let photoList = try JSONDecoder().decode([Photo].self, from: data)
                completion(photoList)
            } catch {
                // TODO: better error handling
                completion(nil)
            }
        }
    }

    static func getPhoto(url: URL, completion: @escaping (UIImage?) -> Void) {
        getData(request: .image(url)) { data in completion(data.flatMap(UIImage.init)) }
    }
}
