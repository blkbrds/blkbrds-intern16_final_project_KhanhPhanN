//
//  DownloadService.swift
//  FinalProject
//
//  Created by PCI0007 on 10/2/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class DownloadService {
    
    static let shared = DownloadService()
    
    var downloadedResults: [Episode] {
        downloadedEpisodes()
    }
    
    func downloadEpisode(_ episode: Episode) {
        do {
            var episodes = downloadedEpisodes()
            episodes.insert(episode, at: 0)
            let data = try JSONEncoder().encode(episodes)
            UserDefaults.standard.set(data, forKey: UserDefaults.downloadedEpisodesKey)
        } catch let err {
            print("Error: ", err)
        }
    }
    
    func downloadedEpisodes() -> [Episode] {
        guard let episodeData = UserDefaults.standard.value(forKey: UserDefaults.downloadedEpisodesKey) as? Data else { return [] }
        do {
            let data = try JSONDecoder().decode([Episode].self, from: episodeData)
            return data
        } catch let err {
            print("Error: ", err)
        }
        return []
    }
}
