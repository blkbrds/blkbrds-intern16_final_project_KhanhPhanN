//
//  HeaderCollectionCell.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit
import SDWebImage

final class HeaderCollectionCell: UICollectionViewCell {

    var viewModel: HeaderCollectionCellViewModel? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func updateUI() {
        trackNameLabel.text = viewModel?.trackName
        artistNameLabel.text = viewModel?.artistName
        guard let url = URL(string: viewModel?.artworkUrl600 ?? "") else { return }
        coverImageView.sd_setImage(with: url, completed: nil)
        coverImageView.sd_imageTransition = .fade
    }
}
