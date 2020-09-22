//
//  PodcastResult.swift
//  FinalProject
//
//  Created by PCI0007 on 9/22/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

struct PodcastResult: Codable {
  let resultCount: Int
  let results: [Podcast]
}
