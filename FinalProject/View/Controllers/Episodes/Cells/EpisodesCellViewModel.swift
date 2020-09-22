//
//  EpisodesCellViewModel.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class EpisodesCellViewModel {
    
    private(set) var title: String
    private(set) var description: String
    private(set) var imageUrl: String
    
    init(title: String, description: String, imageUrl: String) {
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
    }
}
