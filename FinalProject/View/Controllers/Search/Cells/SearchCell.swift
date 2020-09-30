//
//  SearchCell.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit
import SDWebImage

final class SearchCell: UITableViewCell {
    
    var viewModel: SearchCellViewModel? {
        didSet {
            updateUI()
        }
    }

    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var genreNamLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func updateUI() {
        trackNameLabel.text = viewModel?.trackName
        artistNameLabel.text = viewModel?.artistName
        genreNamLabel.text = viewModel?.primaryGenreName
        
        guard let url = URL(string: viewModel?.artworkUrl600 ?? "") else { return }
        trackImageView.sd_setImage(with: url, placeholderImage: nil, options: .highPriority, context: [.imageThumbnailPixelSize: CGSize(width: 100, height: 100)])
        trackImageView.sd_imageTransition = .fade
    }
}
