//
//  SearchCellViewModel.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class SearchCellViewModel {
    
    private(set) var trackName: String
    private(set) var artistName: String
    private(set) var artworkUrl600: String
    private(set) var primaryGenreName: String
    
    init(trackName: String, artistName: String, artworkUrl600: String, primaryGenreName: String) {
        self.trackName = trackName
        self.artistName = artistName
        self.artworkUrl600 = artworkUrl600
        self.primaryGenreName = primaryGenreName
    }
}
