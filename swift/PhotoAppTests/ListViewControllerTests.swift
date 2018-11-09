//
//  ListViewControllerTests.swift
//  PhotoAppTests
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

@testable import PhotoApp
import XCTest

class ListViewControllerTests: BaseSnapshotTest {

    func testIfDefaultLayoutLooksGood() {
        let max = 10
        let items = (0..<max).map { StubDetailViewModel(hue: CGFloat($0)/CGFloat(max)) }
        let viewModel = StubListViewModel(title: "Title", items: items)
        let viewController = ListViewController(viewModel: viewModel)
        FBSnapshotVerifyView(viewController.view)
    }
}
