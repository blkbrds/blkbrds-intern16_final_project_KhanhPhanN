//
//  HeaderTableCell.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

protocol HeaderTableCellDelegate: class {
    func cell(_ cell: HeaderTableCell, needsPerform action: HeaderTableCell.Action)
}

let kScreenSize: CGRect = UIScreen.main.bounds

final class HeaderTableCell: UITableViewCell {
    
    enum Action {
        case didSelectCell(data: Podcast)
    }
    
    struct Configuration {
        static let inset: CGFloat = 32
        static let itemWidth: CGFloat = kScreenSize.width - Configuration.inset * 2
    }

    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var viewModel = HeaderTableCellViewModel()
    
    weak var delegate: HeaderTableCellDelegate?
    
    private var oldIndex: Int = 0
    private var scrollOffsetX: CGFloat {
        let contentOffsetX: CGFloat = collectionView.contentOffset.x
        let scrollOffsetX: CGFloat = CGFloat(contentOffsetX / kScreenSize.width)
        return scrollOffsetX
    }
    private var currentIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        getAPI(url: Api.Path.Featured.top20Url)
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "HeaderCollectionCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "HeaderCollectionCell")

        collectionView.contentInset = UIEdgeInsets(top: 0, left: Configuration.inset, bottom: 0, right: Configuration.inset)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.decelerationRate = .fast
        let flowLayout = HorizontalCollectionViewLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        flowLayout.itemSize = CGSize(width: Configuration.itemWidth,
                                     height: 250)
        collectionView.collectionViewLayout = flowLayout
    }
    
    private func getAPI(url: String) {
        viewModel.getData(url: url) { (result) in
            if result {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }

}

// MARK: - Extensions
extension HeaderTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.podcast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollectionCell", for: indexPath) as? HeaderCollectionCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.cell(HeaderTableCell(), needsPerform: .didSelectCell(data: viewModel.podcast[indexPath.row]))
        }
    }
}
