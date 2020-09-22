//
//  EpisodesCell.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit
import SDWebImage

final class EpisodesCell: UITableViewCell {
    
    var viewModel: EpisodesCellViewModel? {
        didSet {
            updateUI()
        }
    }

    @IBOutlet private weak var trackImageView: UIImageView!
    @IBOutlet private weak var trackNameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func updateUI() {
        trackNameLabel.text = viewModel?.title
        descriptionLabel.text = viewModel?.description
        
        guard let url = URL(string: viewModel?.imageUrl.httpsUrlString ?? "") else { return }
        trackImageView.sd_setImage(with: url, placeholderImage: nil, options: .highPriority, context: [.imageThumbnailPixelSize: CGSize(width: 100, height: 100)])
        trackImageView.sd_imageTransition = .fade
    }
}
