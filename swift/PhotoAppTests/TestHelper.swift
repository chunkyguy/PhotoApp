//
//  TestHelper.swift
//  PhotoAppTests
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//
@testable import PhotoApp
import FBSnapshotTestCase
import Foundation

class BaseSnapshotTest: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        recordMode = false
        agnosticOptions = .screenSize
    }
}

struct StubDetailViewModel {
    let hue: CGFloat

    init(hue: CGFloat = 0.3) {
        self.hue = hue
    }
}

extension StubDetailViewModel: ListItemViewModelType {
    var itemSize: CGSize {
        return CGSize(width: 150, height: 150)
    }

    var details: DetailViewModelType {
        return self
    }

    var image: UIImage {
        return UIImage.make(with: UIColor(hue: hue, saturation: 0.7, brightness: 1.0, alpha: 1.0))
    }

    func loadImage(completion: @escaping (Bool) -> Void) {}
}

extension StubDetailViewModel: DetailViewModelType {
    var header: String {
        return "Photo Details"
    }
    var title: String {
        return "This photo is pretty awesome!"
    }
}

struct StubListViewModel {
    let title: String
    let items: [ListItemViewModelType]

    init(title: String, items: [ListItemViewModelType]) {
        self.title = title
        self.items = items
    }
}

extension StubListViewModel: ListViewModelType {
    func loadPhotoList(completion: @escaping (Bool) -> Void) {}
}


func loadData(file: String) -> Data? {
    let bundle = Bundle(for: BaseSnapshotTest.self)
    guard let path = bundle.url(forResource: file, withExtension: "json") else {
        return nil
    }
    do {
        return try Data(contentsOf: path)
    } catch {
        return nil
    }
}
