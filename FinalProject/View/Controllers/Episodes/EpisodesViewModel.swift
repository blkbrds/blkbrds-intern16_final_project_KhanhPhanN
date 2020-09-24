//
//  EpisodesViewModel.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import RealmSwift
import AVFoundation

final class EpisodesViewModel {
    
    let podcast: Podcast
    private(set) var episode = [Episode]()
    
    init(podcast: Podcast) {
        self.podcast = podcast
    }
    
    func getEpisodesData(completion: @escaping (Bool) -> Void) {
        guard let feedUrl = podcast.feedUrl else { return }
        Api.Episode.fetchEpisodes(feedUrlSting: feedUrl) { (episodes) in
            self.episode = episodes
            completion(true)
        }
    }
    
    func cellForRowAt(indexPath: IndexPath) -> EpisodesCellViewModel {
        let title = episode[indexPath.row].title
        let description = episode[indexPath.row].description
        let imageUrl = episode[indexPath.row].imageUrl ?? ""
        return EpisodesCellViewModel(title: title, description: description, imageUrl: imageUrl)
    }
    
    func isLiked() -> Bool {
        do {
            let realm = try Realm()
            let podcast = realm.objects(Podcast.self).filter("trackName = '\(self.podcast.trackName ?? "")'")
            if podcast.isEmpty {
                return false
            } else {
                return true
            }
        } catch {
            return false
        }
    }
    
    func reaction() -> Bool {
        do {
            if !isLiked() {
                let realm = try Realm()
                let podcast = Podcast()
                podcast.trackName = "\(self.podcast.trackName ?? "")"
                podcast.artistName = "\(self.podcast.artistName ?? "")"
                podcast.artworkUrl600 = "\(self.podcast.artworkUrl600 ?? "")"
                podcast.feedUrl = "\(self.podcast.feedUrl ?? "")"
                try realm.write {
                    realm.add(podcast)
                }
                return true
            } else {
                let realm = try Realm()
                let podcast = realm.objects(Podcast.self).filter("trackName = '\(self.podcast.trackName ?? "")'")
                try realm.write {
                    realm.delete(podcast)
                }
                return false
            }
        } catch {
            return false
        }
    }
}

extension EpisodesViewModel {
    
    func viewModelForItem(indexPath: IndexPath) -> PlayerViewModel {
        return PlayerViewModel(episode: episode[indexPath.row], playlist: episode)
    }
}
