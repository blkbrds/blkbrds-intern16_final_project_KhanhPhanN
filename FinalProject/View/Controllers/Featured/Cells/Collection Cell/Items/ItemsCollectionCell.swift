//
//  ItemsCollectionCell.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit
import SDWebImage

final class ItemsCollectionCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    var viewModel: ItemsCollectionCellViewModel? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func updateUI() {
        trackNameLabel.text = viewModel?.trackName
        artistNameLabel.text = viewModel?.artistName
        
        guard let url = URL(string: viewModel?.artworkUrl600 ?? "") else { return }
        trackImageView.sd_setImage(with: url, placeholderImage: nil, options: .highPriority, context: [.imageThumbnailPixelSize: CGSize(width: 200, height: 200)])
        trackImageView.sd_imageTransition = .fade
    }
}
