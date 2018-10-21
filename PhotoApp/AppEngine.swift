//
//  AppEngine.swift
//  PhotoApp
//
//  Created by Sidharth Juyal on 21/10/2018.
//  Copyright © 2018 Sidharth Juyal. All rights reserved.
//


import UIKit

class AppEngine {
    private var window: UIWindow?

    init() {
    }

    func start(window: UIWindow) {
        let listViewModel = PhotoListViewModel()
        let listViewController = ListViewController(viewModel: listViewModel)
        let rootViewController = UINavigationController(rootViewController: listViewController)
        decorate(navBar: rootViewController.navigationBar)
        window.rootViewController = rootViewController

        window.backgroundColor = .green
        self.window = window
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
