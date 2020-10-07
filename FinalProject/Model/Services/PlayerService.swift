//
//  PlayerService.swift
//  FinalProject
//
//  Created by PCI0007 on 9/24/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer
import AVKit

final class PlayerService {
    
    static let managePlaying = PlayerService()
    init() {}
    
    var player: AVPlayer = AVPlayer()
    
    func playEpisode(urlString: String) {
        guard let url = URL(string: urlString.httpsUrlString) else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    func playEpisodeUsingFileUrl(urlString: String) {
        guard let fileUrl = URL(string: urlString) else { return }
        let fileName = fileUrl.lastPathComponent

        guard var trueLocation = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        trueLocation.appendPathComponent(fileName)
        let playerItem = AVPlayerItem(url: trueLocation)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    func play() {
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    @objc func prevTrack() { }
    
    func nextTrack() { }
    
    func loop() {
        NotificationCenter.default.addObserver(self, selector: #selector(controlLoopMode), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    @objc func controlLoopMode() {
        player.seek(to: CMTime.zero)
        player.play()
    }
    
    func handleTimeSlider(sliderValue: Float) {
        let percentage = sliderValue
        guard let duration = player.currentItem?.duration else { return }
        let durationInSeconds = CMTimeGetSeconds(duration)
        let seekTimeInSeconds = Float64(percentage) * durationInSeconds
        let seekTime = CMTimeMakeWithSeconds(seekTimeInSeconds, preferredTimescale: 1)
        MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPNowPlayingInfoPropertyElapsedPlaybackTime] = seekTimeInSeconds
        player.seek(to: seekTime)
    }
}
