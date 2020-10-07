//
//  FavouritesCell.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit
import SDWebImage

final class FavouritesCell: UICollectionViewCell {
    
    var viewModel: FavouritesCellViewModel? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var trackImageView: UIImageView!
    @IBOutlet private weak var trackNameLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func updateUI() {
        trackNameLabel.text = viewModel?.trackName
        artistNameLabel.text = viewModel?.artistName
        
        guard let url = URL(string: viewModel?.artworkUrl600 ?? "") else { return }
        trackImageView.sd_setImage(with: url, placeholderImage: nil, options: .highPriority, context: [.imageThumbnailPixelSize: CGSize(width: 200, height: 200)])
    }
}
