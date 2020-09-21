//
//  HorizontalCollectionViewLayout.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class HorizontalCollectionViewLayout: UICollectionViewFlowLayout {
    
    private var previousOffset: CGFloat = 0
    private var currentPage: Int = 0

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        if previousOffset > collectionView.contentOffset.x && velocity.x < 0 {
            currentPage = max(currentPage - 1, 0)
        } else if previousOffset < collectionView.contentOffset.x && velocity.x > 0 {
            currentPage = min(currentPage + 1, numberOfItems - 1)
        }
        let proposedOffsetX = (itemSize.width + minimumInteritemSpacing) * CGFloat(currentPage) - collectionView.contentInset.left
        previousOffset = proposedOffsetX
        return CGPoint(x: proposedOffsetX, y: proposedContentOffset.y)
    }
}
