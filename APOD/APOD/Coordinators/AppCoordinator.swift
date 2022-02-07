//
//  AppCoordinator.swift
//  APOD
//
//  Created by Garima Ashish Bisht on 05/02/22.
//

import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var rootViewController: UIViewController {
        return tabBarController
    }
    
    private let tabBarController = UITabBarController()

    // MARK: - Initialization

    override init() {
        super.init()
        setup()
    }
    
    func setup() {
        setupTabBarController()
        setupCoordinators()
    }
    
    func setupTabBarController() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.black
            
            tabBarController.tabBar.standardAppearance = appearance
            tabBarController.tabBar.scrollEdgeAppearance = tabBarController.tabBar.standardAppearance
        }
    }
    
    func setupCoordinators() {
        let homeCoordinator = configureHomeCoordinator()
        let favouriteCoordinator = configureFavouriteCoordinator()
        
        tabBarController.viewControllers = [
            homeCoordinator.rootViewController, favouriteCoordinator.rootViewController
        ]
        
        childCoordinators.append(homeCoordinator)
        childCoordinators.append(favouriteCoordinator)
    }
    
    func configureHomeCoordinator() -> HomeCoordinator {
        let item = UITabBarItem(tabBarSystemItem: .recents, tag: 0)
        item.isEnabled = true
        return HomeCoordinator(tabBarItem: item)
    }
    
    func configureFavouriteCoordinator() -> FavouriteCoordinator {
        return FavouriteCoordinator(tabBarItem: UITabBarItem(tabBarSystemItem: .favorites, tag: 0))
    }
    
    override func start() {
        childCoordinators.forEach { (childCoordinator) in
            childCoordinator.start()
        }
    }
}

