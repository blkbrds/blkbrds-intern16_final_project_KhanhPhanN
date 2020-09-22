//
//  BaseTabBarController.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let layout = UICollectionViewFlowLayout()
        let favouriteVC = FavouritesController(collectionViewLayout: layout)
        let favouriteNavi = UINavigationController(rootViewController: favouriteVC)
        favouriteVC.tabBarItem = UITabBarItem(title: "Favourites", image: #imageLiteral(resourceName: "favourite"), selectedImage: #imageLiteral(resourceName: "favourite-sel"))
        
        let searchVC = SearchController()
        let searchNavi = UINavigationController(rootViewController: searchVC)
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: #imageLiteral(resourceName: "search"), selectedImage: #imageLiteral(resourceName: "search-sel"))
        
        let featuredVC = FeaturedController()
        let featuredNavi = UINavigationController(rootViewController: featuredVC)
        featuredVC.tabBarItem = UITabBarItem(title: "Featured", image: #imageLiteral(resourceName: "star"), selectedImage: #imageLiteral(resourceName: "star-sel"))
        
        let downloadVC = DownloadController()
        let downloadNavi = UINavigationController(rootViewController: downloadVC)
        downloadVC.tabBarItem = UITabBarItem(title: "Download", image: #imageLiteral(resourceName: "album"), selectedImage: #imageLiteral(resourceName: "album-sel"))
        
        viewControllers = [featuredNavi, searchNavi, favouriteNavi, downloadNavi]
        tabBar.tintColor = .systemOrange
        tabBar.barTintColor = .black
    }
}
