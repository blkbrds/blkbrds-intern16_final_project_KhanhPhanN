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
    var playlist: [Episode]
    var index: Int
    
    init(episode: Episode, playlist: [Episode], index: Int) {
        self.episode = episode
        self.playlist = playlist
        self.index = index
    }
    
    func cellForRowAt(indexPath: IndexPath) -> PlaylistCellViewModel {
        let title = playlist[indexPath.row].title
        let author = playlist[indexPath.row].author
        let imageUrl = playlist[indexPath.row].imageUrl ?? ""
        return PlaylistCellViewModel(title: title, author: author, imageUrl: imageUrl)
    }
}
