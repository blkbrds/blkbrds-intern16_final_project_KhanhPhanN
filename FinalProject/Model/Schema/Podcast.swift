//
//  Podcast.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import RealmSwift

class Podcast: Object, Codable {
    @objc dynamic var trackName: String?
    @objc dynamic var artistName: String?
    @objc dynamic var artworkUrl600: String?
    @objc dynamic var primaryGenreName: String?
    @objc dynamic var feedUrl: String?
}
