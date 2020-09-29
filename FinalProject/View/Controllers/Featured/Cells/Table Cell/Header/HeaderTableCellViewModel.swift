//
//  HeaderTableCellViewModel.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class HeaderTableCellViewModel {
    
    var podcast: [Podcast] = []
    
    func cellForRowAt(indexPath: IndexPath) -> HeaderCollectionCellViewModel? {
        let trackName: String = podcast[indexPath.row].trackName ?? ""
        let artistName: String = podcast[indexPath.row].artistName ?? ""
        let artworkUrl600: String = podcast[indexPath.row].artworkUrl600 ?? ""
        return HeaderCollectionCellViewModel(trackName: trackName, artistName: artistName, artworkUrl600: artworkUrl600)
    }
    
    func getData(url: String, completion: @escaping (Bool) -> Void) {
        let limit = "20"
        Api.Featured.fetchPodcasts(genreID: nil, limit: limit) { (data) in
            self.podcast = data
            completion(true)
        }
    }
}
