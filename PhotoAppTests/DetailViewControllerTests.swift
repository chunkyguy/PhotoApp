//
//  DetailViewControllerTests.swift
//  PhotoAppTests
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//

@testable import PhotoApp
import XCTest

class DetailViewControllerTests: BaseSnapshotTest {

    func testIfDefaultLayoutLooksGood() {
        let viewModel = StubDetailViewModel()
        let viewController = DetailViewController(viewModel: viewModel)
        FBSnapshotVerifyView(viewController.view)
    }
}
