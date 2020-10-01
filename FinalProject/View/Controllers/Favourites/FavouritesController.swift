//
//  FavouritesController.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

private let favouriteCellID = "FavouritesCell"

final class FavouritesController: UICollectionViewController {
    
    // MARK: - Properties
    private var viewModel = FavouritesViewModel()
    private let screenWidth = UIScreen.main.bounds.width
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Private functions
    private func setupNavigation() {
        title = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? BaseTabBarController
        mainTabBarController?.viewControllers?[2].tabBarItem.badgeValue = nil
    }
    
    private func setupView() {
        setupNavigation()
        setupCollectionView()
        getDataForCell()
    }
    
    private func setupCollectionView() {
        viewModel.delegate = self
        viewModel.setupObserve()
        
        let nib = UINib(nibName: favouriteCellID, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: favouriteCellID)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (screenWidth - 100) / 2, height: 210)
        layout.minimumLineSpacing = 32
        layout.sectionInset = UIEdgeInsets(top: 16, left: 32, bottom: 16, right: 32)
        collectionView.collectionViewLayout = layout
    }
    
    private func getDataForCell() {
        viewModel.getData { (datas) in
            if datas {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

// MARK: - UICollectionView
extension FavouritesController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.podcasts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: favouriteCellID, for: indexPath) as? FavouritesCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let podcast = viewModel.podcasts[indexPath.row]
        let episodesViewModel = EpisodesViewModel(podcast: podcast)
        let episodesController = EpisodesController(viewModel: episodesViewModel)
        navigationController?.pushViewController(episodesController, animated: true)
    }
}

// MARK: - FavouritesViewModelDelegate
extension FavouritesController: FavouritesViewModelDelegate {
    func viewModel(_ viewModel: FavouritesViewModel) {
        getDataForCell()
    }
}
