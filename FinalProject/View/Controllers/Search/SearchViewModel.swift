//
//  SearchViewModel.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class SeachViewModel {
    
    var podcast: [Podcast] = []
    
    func cellForRowAt(indexPath: IndexPath) -> SearchCellViewModel? {
        let trackName = podcast[indexPath.row].trackName ?? ""
        let artistName = podcast[indexPath.row].artistName ?? ""
        let artworkUrl600 = podcast[indexPath.row].artworkUrl600 ?? ""
        let primaryGenreName = podcast[indexPath.row].primaryGenreName ?? ""
        return SearchCellViewModel(trackName: trackName,
                                   artistName: artistName,
                                   artworkUrl600: artworkUrl600,
                                   primaryGenreName: primaryGenreName)
    }
    
    func getData(key: String, completion: @escaping (Bool) -> Void) {
        Api.Search.searchPodcasts(searchText: key) { (data) in
            self.podcast = data
            completion(true)
        }
    }
}
