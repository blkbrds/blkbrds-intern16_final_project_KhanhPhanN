//
//  PlaylistCellViewModel.swift
//  FinalProject
//
//  Created by PCI0007 on 9/29/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class PlaylistCellViewModel {
    
    private(set) var title: String
    private(set) var author: String
    private(set) var imageUrl: String
    
    init(title: String, author: String, imageUrl: String) {
        self.title = title
        self.author = author
        self.imageUrl = imageUrl
    }
}
