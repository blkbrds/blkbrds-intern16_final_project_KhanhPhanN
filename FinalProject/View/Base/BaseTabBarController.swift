//
//  BaseTabBarController.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class BaseTabBarController: UITabBarController {
    
    // MARK: - Properties
    let musicPlayerView = Bundle.main.loadNibNamed("PlayerView", owner: self, options: nil)?.first as? PlayerView

    var maximizedTopAnchorConstraint: NSLayoutConstraint!
    var minimizedTopAnchorConstraint: NSLayoutConstraint!
    var bottomAnchorConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupPlayerDetailsView()
    }
    
    // MARK: - Setup View Controllers
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
    
    // MARK: - Setup Player Views
    @objc func minimizePlayerDetails() {
        maximizedTopAnchorConstraint.isActive = false
        bottomAnchorConstraint.constant = view.frame.height
        minimizedTopAnchorConstraint.isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.tabBar.frame.origin.y = self.view.frame.size.height - self.tabBar.frame.height
            self.musicPlayerView?.miniPlayerView.alpha = 1
            self.musicPlayerView?.maximizedPlayerView.alpha = 0
        })
    }
    
    func maximizePlayerDetails() {
        minimizedTopAnchorConstraint.isActive = false
        maximizedTopAnchorConstraint.isActive = true
        maximizedTopAnchorConstraint.constant = 0
        bottomAnchorConstraint.constant = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.tabBar.frame.origin.y = self.view.frame.size.height
            self.musicPlayerView?.miniPlayerView.alpha = 0
            self.musicPlayerView?.maximizedPlayerView.alpha = 1
        })
    }
    
    private func setupPlayerDetailsView() {
        view.insertSubview(musicPlayerView ?? UIView(), belowSubview: tabBar)
        musicPlayerView?.translatesAutoresizingMaskIntoConstraints = false
        
        maximizedTopAnchorConstraint = musicPlayerView?.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        maximizedTopAnchorConstraint.isActive = true
        
        bottomAnchorConstraint = musicPlayerView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        bottomAnchorConstraint.isActive = true
        
        minimizedTopAnchorConstraint = musicPlayerView?.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -(musicPlayerView?.miniPlayerView.frame.height ?? 0))
        
        musicPlayerView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        musicPlayerView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
