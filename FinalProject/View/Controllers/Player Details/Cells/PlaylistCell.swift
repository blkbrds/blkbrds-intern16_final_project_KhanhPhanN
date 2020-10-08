//
//  PlaylistCell.swift
//  FinalProject
//
//  Created by PCI0007 on 9/29/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class PlaylistCell: UITableViewCell {
    
    var viewModel: PlaylistCellViewModel? {
        didSet {
            updateUI()
            createNowPlayingAnimation()
        }
    }
    
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet private weak var thumbImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet weak var playingImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playingImageView.isHidden = true
        backgroundColorView.alpha = 0
    }
    
    private func updateUI() {
        titleLabel.text = viewModel?.title
        authorNameLabel.text = viewModel?.author
        guard let url = URL(string: viewModel?.imageUrl ?? "") else { return }
        thumbImageView.sd_setImage(with: url)
    }
    
    private func createNowPlayingAnimation() {
        playingImageView.animationImages = AnimationFrames.createFrames()
        playingImageView.animationDuration = 0.7
        playingImageView.startAnimating()
    }
}
