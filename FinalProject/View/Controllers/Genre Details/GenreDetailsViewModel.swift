//
//  GenreDetailsViewModel.swift
//  FinalProject
//
//  Created by PCI0007 on 9/29/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class GenreDetailsViewModel {
    
    var podcast: [Podcast] = []
    let genre: FeaturedViewModel.Genres
    
    init(genre: FeaturedViewModel.Genres) {
        self.genre = genre
    }
    
    func cellForRowAt(indexPath: IndexPath) -> GenreCellViewModel? {
        let trackName = podcast[indexPath.row].trackName ?? ""
        let artistName = podcast[indexPath.row].artistName ?? ""
        let artworkUrl600 = podcast[indexPath.row].artworkUrl600 ?? ""
        let trackCount = podcast[indexPath.row].trackCount ?? 0
        return GenreCellViewModel(trackName: trackName, artistName: artistName, artworkUrl600: artworkUrl600, trackCount: trackCount)
    }
    
    func getData(completion: @escaping (Bool) -> Void) {
        let limit: String = "200"
        Api.Featured.fetchPodcasts(genreID: genre.genreID, limit: limit) { (data) in
            self.podcast = data
            completion(true)
        }
    }
}
