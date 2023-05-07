//
//  ViewController.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/04/16.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarStyle()
        self.viewControllers = [createNavController(for: HomeViewController(), title: "Home", image: UIImage(systemName: "house"))]
    }
    
    private func setTabBarStyle() {
        self.navigationItem.hidesBackButton = true
        tabBar.tintColor = .white
        tabBar.isTranslucent = true
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let apparence = UITabBarAppearance()
        apparence.backgroundColor = Colors.darkMagenta.withAlphaComponent(0.2)
        apparence.backgroundEffect = blurEffect
        tabBar.standardAppearance = apparence
        tabBar.scrollEdgeAppearance = apparence
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.navigationBar.tintColor = .white
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        rootViewController.navigationItem.title = title
        return navController
    }

}
