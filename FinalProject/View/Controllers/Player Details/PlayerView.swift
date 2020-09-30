//
//  PlayerView.swift
//  FinalProject
//
//  Created by PCI0007 on 9/24/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation
import AVKit

final class PlayerView: UIView {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var maximizedPlayerView: UIView!
    @IBOutlet weak var miniPlayerView: UIView!
    
    @IBOutlet weak var miniThumbImageView: UIImageView!
    @IBOutlet weak var miniTitleLabel: UILabel!
    @IBOutlet weak var miniAuthorLabel: UILabel!
    @IBOutlet weak var miniPlayPauseButton: UIButton!
    @IBOutlet weak var miniTimeSlider: UISlider!
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    
    // MARK: - Properties
    var viewModel: PlayerViewModel? {
        didSet {
            updateUI()
            playEpisode()
            tableView.reloadData()
        }
    }
    
    private let playerService = PlayerService.managePlaying
    private var isPause: Bool = false
    private var currentPage: Int = 0
    
    // MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    // MARK: - Private functions
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
        rotateView()
        setupGestures()
        setupTableView()
        observePlayerCurrentTime()
        scrollView.delegate = self
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapMaximize))
        miniPlayerView.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    private func rotateView(duration: Double = 5.0) {
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (timer) in
            if self.isPause {
                timer.invalidate()
                return
            }
            self.thumbImageView.transform = self.thumbImageView.transform.rotated(by: CGFloat.pi / 360)
        }
    }
    
    // MARK: - Actions
    @IBAction func handleDismissTouchUpInside(_ sender: UIButton) {
        let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? BaseTabBarController
        mainTabBarController?.minimizePlayerDetails()
    }
    
    @IBAction func handleTimeSliderTouchUpInside(_ sender: UISlider) {
        playerService.handleTimeSlider(sliderValue: timeSlider.value)
    }
    
    @IBAction func handleLoppTouchUpInside(_ sender: UIButton) {
        let button: UIButton = sender
        button.isSelected = !button.isSelected
        if (button.isSelected) {
            playerService.loop()
            button.tintColor = .systemOrange
        } else {
            button.tintColor = .white
        }
    }
    
    @IBAction func handleBackwardTouchUpInside(_ sender: UIButton) {
        guard let numberIndex = viewModel?.index else { return }
        if numberIndex == 0 {
            guard let prevEpisode = viewModel?.playlist[0] else { return }
            viewModel?.episode = prevEpisode
            playerService.playEpisode(urlString: viewModel?.episode.streamUrl ?? "")
            updateUI()
        } else {
            guard let prevEpisode = viewModel?.playlist[numberIndex - 1] else { return }
            viewModel?.episode = prevEpisode
            playerService.playEpisode(urlString: viewModel?.episode.streamUrl ?? "")
            updateUI()
            viewModel?.index -= 1
        }
    }
    
    @IBAction func handlePlayPauseTouchUpInside(_ sender: UIButton) {
        if playerService.player.timeControlStatus == .paused {
            playerService.play()
            playPauseButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            miniPlayPauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            isPause = false
            rotateView()
        } else {
            playerService.pause()
            playPauseButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            miniPlayPauseButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
            isPause = true
        }
    }
    
    @IBAction func handleForwardTouchUpInside(_ sender: UIButton) {
        guard let numberIndex = viewModel?.index else { return }
        if numberIndex + 1 == viewModel?.playlist.count ?? 0 - 1 {
            viewModel?.index = 0
            guard let nextEpisode = viewModel?.playlist[0] else { return }
            viewModel?.episode = nextEpisode
            playerService.playEpisode(urlString: viewModel?.episode.streamUrl ?? "")
            updateUI()
        } else {
            guard let nextEpisode = viewModel?.playlist[numberIndex + 1] else { return }
            viewModel?.episode = nextEpisode
            playerService.playEpisode(urlString: viewModel?.episode.streamUrl ?? "")
            updateUI()
            viewModel?.index += 1
        }
    }
    
    @IBAction func handlePlaylistTouchUpInside(_ sender: UIButton) {
        if currentPage == 1 {
            currentPage = 1
        } else {
            currentPage += 1
        }
        let x = scrollView.frame.width * CGFloat(currentPage)
            scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    
    @IBAction func handleVolumeTouchUpInside(_ sender: UISlider) {
    }
    
    @IBAction func handleMiniPlayPauseTouchUpInside(_ sender: UIButton) {
        if playerService.player.timeControlStatus == .paused {
            playerService.play()
            miniPlayPauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            playPauseButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            isPause = false
            rotateView()
        } else {
            playerService.pause()
            miniPlayPauseButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
            playPauseButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            isPause = true
        }
    }
}

// MARK: - Player Services
extension PlayerView {
    
    private func playEpisode() {
        if viewModel?.episode.fileUrl != nil {
            playerService.playEpisodeUsingFileUrl(urlString: viewModel?.episode.fileUrl ?? "")
        } else {
            playerService.playEpisode(urlString: viewModel?.episode.streamUrl ?? "")
        }
        NotificationCenter.default.addObserver(self, selector: #selector(audioPlayerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerService.player)
    }
    
    @objc func audioPlayerDidFinishPlaying(notification: NSNotification) {
        
    }
    
    private func observePlayerCurrentTime() {
        let interval = CMTimeMake(value: 1, timescale: 2)
        playerService.player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { (time) in
            self.currentTimeLabel.text = time.toDisplayString()
            let durationTime = self.playerService.player.currentItem?.duration
            self.durationLabel.text = durationTime?.toDisplayString()
            self.updateCurrentTimeSlider()
        }
    }
    
    private func updateCurrentTimeSlider() {
        let currentTimeSeconds = CMTimeGetSeconds(playerService.player.currentTime())
        let durationSeconds = CMTimeGetSeconds(playerService.player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let percentage = currentTimeSeconds / durationSeconds
        self.timeSlider.value = Float(percentage)
        
        self.miniTimeSlider.value = Float(percentage)
        miniTimeSlider.setThumbImage(UIImage(), for: .normal)
    }
}

// MARK: - Handle Actions
extension PlayerView {
    @objc func handleTapMaximize() {
        let mainTabBarController =  UIApplication.shared.keyWindow?.rootViewController as? BaseTabBarController
        mainTabBarController?.maximizePlayerDetails()
    }
}

extension PlayerView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
    }
    
}

// MARK: - UITableView
extension PlayerView: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        let nib = UINib(nibName: "PlaylistCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "PlaylistCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.playlist.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistCell", for: indexPath) as? PlaylistCell else { return UITableViewCell() }
        cell.viewModel = viewModel?.cellForRowAt(indexPath: indexPath)
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextEpisode = viewModel?.playlist[indexPath.row] else { return }
        viewModel?.episode = nextEpisode
        playerService.playEpisode(urlString: viewModel?.episode.streamUrl ?? "")
        updateUI()
    }
}
