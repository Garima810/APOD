//
//  HomeCoordinator.swift
//  APOD
//
//  Created by Garima Ashish Bisht on 05/02/22.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    private var navigationController: UINavigationController!

    private var viewModel = HomeViewModel(with: APODDataManager())

    // MARK: - Public API
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    // MARK: - Setup
    
    init(tabBarItem: UITabBarItem) {
        super.init()
        setupRootViewController(with: homeViewController(with: tabBarItem))
    }
    
    private func setupRootViewController(with viewController: UIViewController) {
        navigationController = UINavigationController(rootViewController: viewController)
        navigationController.delegate = self
    }
    
    private func homeViewController(with tabBarItem: UITabBarItem) -> UIViewController {
        let homeViewController =  HomeViewController(viewModel: viewModel)
        homeViewController.tabBarItem = tabBarItem
        return homeViewController
    }
    
    // MARK: - Helper Methods
    
    override func start() {
    }

}
