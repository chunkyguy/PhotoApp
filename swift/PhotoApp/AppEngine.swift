//
//  AppEngine.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//


import UIKit

class AppEngine {
    private let window = UIWindow(frame: UIScreen.main.bounds)
    private let networkService: NetworkService
    private let imageLoader: ImageLoader

    init() {
        networkService = NetworkService(provider: JSONPlaceholderPhotoProvider())
        imageLoader = ImageLoader(networkService: networkService)
    }

    func start() {

        let listViewController = ListViewController(viewModel: PhotoListViewModel(networkService: networkService, imageLoader: imageLoader))
        let rootViewController = UINavigationController(rootViewController: listViewController)
        decorate(navBar: rootViewController.navigationBar)
        window.rootViewController = rootViewController

        window.backgroundColor = .green

        window.makeKeyAndVisible()
    }

    func stop() {
        // App entering background
    }

    private func decorate(navBar: UINavigationBar) {
        navBar.isTranslucent = true
        navBar.prefersLargeTitles = false
        navBar.setBackgroundImage(
            UIImage(),
            for: .any,
            barMetrics: .default
        )
    }
}
