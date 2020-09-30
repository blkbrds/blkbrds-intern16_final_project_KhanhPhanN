//
//  PlayerViewModel.swift
//  FinalProject
//
//  Created by PCI0007 on 9/24/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class PlayerViewModel {
    
    var episode: Episode
    var playlist = [Episode]()
    
    init(episode: Episode , playlist: [Episode]) {
        self.episode = episode
        self.playlist = playlist
    }
}
