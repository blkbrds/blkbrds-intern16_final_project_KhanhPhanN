//
//  Notification.Ext.swift
//  FinalProject
//
//  Created by PCI0007 on 10/2/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

typealias DownloadProgressInfo = [String: Any]
typealias FavoriteStateInfo = [String: Bool]

extension Notification.Name {
    
    static let downloadProgress = NSNotification.Name("downloadProgress")
    static let downloadComplete = NSNotification.Name("downloadComplete")
    static let savingFavourites = NSNotification.Name("savingFavourites")
}
