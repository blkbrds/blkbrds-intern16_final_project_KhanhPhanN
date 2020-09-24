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
            playEpisode()
        }
    }
    
    let playerService = PlayerService.managePlaying

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
        setupView()
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
    }
    
    private func setupView() {
        backgroundImageView.addBlurEffect()
    }
    
    private func playEpisode() {
        playerService.playEpisode(urlString: viewModel?.episode.streamUrl ?? "")
    }
    
    // MARK: - Actions
    @IBAction func handleDismissTouchUpInside(_ sender: UIButton) {
        let mainTabBarController =  UIApplication.shared.keyWindow?.rootViewController as? BaseTabBarController
        mainTabBarController?.minimizePlayerDetails()
    }
    
    @IBAction func handleTimeSliderTouchUpInside(_ sender: UISlider) {
    }
    
    @IBAction func handleLoppTouchUpInside(_ sender: UIButton) {
        playerService.loop()
    }
    
    @IBAction func handleBackwardTouchUpInside(_ sender: UIButton) {
    }
    
    @IBAction func handlePlayPauseTouchUpInside(_ sender: UIButton) {
        if playerService.player.timeControlStatus == .paused {
            playerService.play()
            playPauseButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        } else {
            playerService.pause()
            playPauseButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        }
    }
    
    @IBAction func handleForwardTouchUpInside(_ sender: UIButton) {
    }
    
    @IBAction func handlePlaylistTouchUpInside(_ sender: UIButton) {
    }
    
    @IBAction func handleVolumeTouchUpInside(_ sender: UISlider) {
    }
    
}
