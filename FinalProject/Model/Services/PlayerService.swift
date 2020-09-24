//
//  PlayerService.swift
//  FinalProject
//
//  Created by PCI0007 on 9/24/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import AVFoundation

final class PlayerService {
    
    static let managePlaying = PlayerService()
    init() {}
    
    var player: AVPlayer = AVPlayer()
    
    // MARK: - Control playing services
    func playEpisode(urlString: String) {
        guard let url = URL(string: urlString.httpsUrlString) else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    func play() {
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    func loop() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { (_) in
            self.player.seek(to: CMTime.zero)
            self.player.play()
        }
    }
}
