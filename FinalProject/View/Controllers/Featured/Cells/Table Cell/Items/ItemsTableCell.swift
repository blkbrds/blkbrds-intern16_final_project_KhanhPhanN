//
//  ItemsTableCell.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

protocol ItemsTableCellDelegate: class {
    func cell(_ cell: ItemsCollectionCell, needsPerform action: ItemsTableCell.Action)
}

final class ItemsTableCell: UITableViewCell {
    
    enum Action {
        case didSelectCell(data: Podcast)
    }
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var genreNameLabel: UILabel!
    @IBOutlet weak var seeAllButton: UIButton!
    
    weak var delegate: ItemsTableCellDelegate?
    
    private let itemsCellId: String = "ItemsCollectionCell"
    
    var viewModel: ItemsTableCellViewModel? {
        didSet {
            viewModel?.getData(completion: { (result) in
                if result {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            })
            genreNameLabel.text = viewModel?.genre.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    // MARK: - Private functions
    private func setupCollectionView() {
        let nib = UINib(nibName: itemsCellId, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: itemsCellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 140, height: 180)
        flowLayout.minimumLineSpacing = 16.0
        flowLayout.minimumInteritemSpacing = 5.0
        flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
        
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.showsHorizontalScrollIndicator = false
    }
}

// MARK: - Extensions
extension ItemsTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.podcast.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemsCellId, for: indexPath) as? ItemsCollectionCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel?.cellForRowAt(indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil, let viewModel = viewModel {
            delegate?.cell(ItemsCollectionCell(), needsPerform: .didSelectCell(data: viewModel.podcast[indexPath.row]))
        }
    }
}

