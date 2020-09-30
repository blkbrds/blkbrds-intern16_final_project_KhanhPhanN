//
//  PlayerView.swift
//  FinalProject
//
//  Created by PCI0007 on 9/24/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class PlayerView: UIView {

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
