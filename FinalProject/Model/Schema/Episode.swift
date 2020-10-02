//
//  Episode.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import FeedKit

struct Episode: Codable {
    let title: String
    let pubDate: Date
    let description: String
    let author: String
    let streamUrl: String

    var fileUrl: String?
    var imageUrl: String?

    init(feedItem: RSSFeedItem) {
        streamUrl = feedItem.enclosure?.attributes?.url ?? ""
        title = feedItem.title ?? ""
        pubDate = feedItem.pubDate ?? Date()
        description = feedItem.iTunes?.iTunesSubtitle ?? feedItem.description ?? ""
        author = feedItem.iTunes?.iTunesAuthor ?? ""
        imageUrl = feedItem.iTunes?.iTunesImage?.attributes?.href
    }
}
