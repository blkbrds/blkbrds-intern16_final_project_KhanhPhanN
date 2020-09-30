//
//  API.Episode.swift
//  FinalProject
//
//  Created by PCI0007 on 9/22/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import FeedKit

extension Api.Episode {
    
    static func fetchEpisodes(feedUrlSting: String?, completionHandler: @escaping ([Episode]) -> Void) {
         guard
             let feedUrlSting = feedUrlSting,
             let url = URL(string: feedUrlSting.httpsUrlString)
             else { return }

        DispatchQueue.global(qos: .background).async {
            let parser = FeedParser(URL: url)
            parser.parseAsync { result in
                switch result {
                case let .success(feed):
                    print("Successfully parse feed:", feed)
                    guard let rssFeed = feed.rssFeed else { return }
                    let episodes = rssFeed.toEpisodes()
                    DispatchQueue.main.async {
                        completionHandler(episodes)
                    }
                case let .failure(parserError):
                    print("Failed to parse XML feed:", parserError)
                }
            }
        }
    }
}
