//
//  FavouritesViewModel.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import RealmSwift

protocol FavouritesViewModelDelegate: class {
    func viewModel(_ viewModel: FavouritesViewModel)
}

final class FavouritesViewModel {
    
    var podcasts: [Podcast] = []
    private(set) var notificationToken: NotificationToken?
    weak var delegate: FavouritesViewModelDelegate?
    
    func cellForRowAt(indexPath: IndexPath) -> FavouritesCellViewModel? {
        let trackName: String = podcasts[indexPath.row].trackName ?? ""
        let artistName: String = podcasts[indexPath.row].artistName ?? ""
        let artworkUrl600: String = podcasts[indexPath.row].artworkUrl600 ?? ""
        return FavouritesCellViewModel(trackName: trackName, artistName: artistName, artworkUrl600: artworkUrl600)
    }
    
    func getData(completion: @escaping (Bool) -> Void) {
        do {
            podcasts.removeAll()
            let realm = try Realm()
            let podcast = realm.objects(Podcast.self)
            for item in podcast {
                let object = Podcast()
                object.trackName = item.trackName ?? ""
                object.artistName = item.artistName ?? ""
                object.artworkUrl600 = item.artworkUrl600 ?? ""
                object.feedUrl = item.feedUrl
                podcasts.insert(object, at: 0)
            }
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    func setupObserve() {
        do {
            let realm = try Realm()
            notificationToken = realm.objects(Podcast.self).observe({ (_) in
                self.delegate?.viewModel(self)
            })
        } catch {
            print("Error...")
        }
    }
}
