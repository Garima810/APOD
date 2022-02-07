//
//  HomeCoordinator.swift
//  APOD
//
//  Created by Garima Ashish Bisht on 05/02/22.
//

import UIKit

class FavouriteCoordinator: Coordinator {
    
    private var navigationController: UINavigationController!

    private var viewModel = FavouriteViewModel()

    // MARK: - Public API
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    // MARK: - Setup
    
    init(tabBarItem: UITabBarItem) {
        super.init()
        setupRootViewController(with: favoriteViewController(with: tabBarItem))
    }
    
    private func setupRootViewController(with viewController: UIViewController) {
        navigationController = UINavigationController(rootViewController: viewController)
        navigationController.delegate = self
    }
    
    private func favoriteViewController(with tabBarItem: UITabBarItem) -> UIViewController {
        let favoriteViewController =  FavouriteViewController(viewModel: viewModel)
        favoriteViewController.tabBarItem = tabBarItem
        return favoriteViewController
    }
    
    // MARK: - Helper Methods
    
    override func start() {
    }

}
