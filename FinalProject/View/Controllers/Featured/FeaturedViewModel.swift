//
//  FreaturedViewModel.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class FeaturedViewModel {
    
    enum Genres: Int, CaseIterable {
        case education = 1, society, music, news, sport
        
        var genreID: String {
            switch self {
            case .education: return Api.Path.Featured.educationUrl
            case .music: return Api.Path.Featured.musicUrl
            case .society: return Api.Path.Featured.societyUrl
            case .news: return Api.Path.Featured.newsUrl
            case .sport: return Api.Path.Featured.sportUrl
            }
        }
        
        var title: String {
            switch self {
            case .education: return "Education"
            case .music: return "Music"
            case .society: return "Society"
            case .news: return "News"
            case .sport: return "Sport"
            }
        }
    }
    
    func viewModelForItem(at indexPath: IndexPath) -> ItemsTableCellViewModel? {
        guard let genre = Genres(rawValue: indexPath.row) else { return nil }
        return ItemsTableCellViewModel(genre: genre)
    }
    
    func viewModelForItem(index: Int) -> GenreDetailsViewModel? {
        guard let genre = Genres(rawValue: index) else { return nil }
        return GenreDetailsViewModel(genre: genre)
    }
}
