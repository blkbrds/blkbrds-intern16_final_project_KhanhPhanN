//
//  PlayerView.swift
//  FinalProject
//
//  Created by PCI0007 on 9/24/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class PlayerView: UIView {
    
    var viewModel: PlayerViewModel? {
        didSet {
            updateUI()
        }
    }

    // MARK: - Outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var maximizedPlayerView: UIView!
    @IBOutlet weak var miniPlayerView: UIView!
    
    @IBOutlet weak var miniThumbImageView: UIImageView!
    @IBOutlet weak var miniTitleLabel: UILabel!
    @IBOutlet weak var miniAuthorLabel: UILabel!
    @IBOutlet weak var miniPlayPauseButton: UIButton!
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func updateUI() {
        guard let url = URL(string: viewModel?.episode.imageUrl ?? "") else { return }
        backgroundImageView.sd_setImage(with: url)
        thumbImageView.sd_setImage(with: url)
        miniThumbImageView.sd_setImage(with: url)
        titleLabel.text = viewModel?.episode.title
        miniTitleLabel.text = viewModel?.episode.title
        authorLabel.text = viewModel?.episode.author
        miniAuthorLabel.text = viewModel?.episode.author
        backgroundImageView.addBlurEffect()
    }
    
    // MARK: - Actions
    @IBOutlet weak var handleDismissTouchUpInside: UIButton!
    @IBOutlet weak var handleTimeSliderTouchUpInside: UISlider!
    @IBOutlet weak var handleLoppTouchUpInside: UIButton!
    @IBOutlet weak var handleBackwardTouchUpInside: UIButton!
    @IBOutlet weak var handlePlayPauseTouchUpInside: UIButton!
    @IBOutlet weak var handleForwardTouchUpInside: UIButton!
    @IBOutlet weak var handlePlaylistTouchUpInside: UIButton!
    @IBOutlet weak var handleVolumeTouchUpInside: UISlider!
}
