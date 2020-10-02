//
//  API.DownloadEpisode.swift
//  FinalProject
//
//  Created by PCI0007 on 10/2/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import Alamofire

extension Api.Download {
    
    typealias EpisodeDownloadCompletion = (fileUrl: String, episodeTitle: String)
    
    static func fetchDownloadEpisode(_ episode: Episode) {
        
        let downloadRequest = DownloadRequest.suggestedDownloadDestination()
        
        Alamofire.download(episode.streamUrl, to: downloadRequest).downloadProgress { (progress) in
            NotificationCenter.default.post(name: .downloadProgress, object: self, userInfo: ["title": episode.title, "progress": progress.fractionCompleted])
            
        }.response { (response) in
            let episodeDownloadCompletion = EpisodeDownloadCompletion(fileUrl: response.destinationURL?.absoluteString ?? "", episodeTitle: episode.title)
            NotificationCenter.default.post(name: .downloadComplete, object: episodeDownloadCompletion, userInfo: nil)
            var downloadedEpisode = DownloadService.shared.downloadedEpisodes()
            
            guard let index = downloadedEpisode.firstIndex(where: {
                $0.title == episode.title && $0.author == episode.author
            }) else { return }
            downloadedEpisode[index].fileUrl = response.destinationURL?.absoluteString ?? ""
            
            do {
                let data = try JSONEncoder().encode(downloadedEpisode)
                UserDefaults.standard.set(data, forKey: UserDefaults.downloadedEpisodesKey)
            } catch let err {
                print("Error: ", err)
            }
        }
    }
}
