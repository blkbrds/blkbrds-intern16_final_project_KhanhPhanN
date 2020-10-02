//
//  DownloadViewModel.swift
//  FinalProject
//
//  Created by PCI0007 on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class DownloadViewModel {
    
    var episodes = DownloadService.shared.downloadedResults
    
    func cellForRowAt(indexPath: IndexPath) -> DownloadCellViewModel {
        let title = episodes[indexPath.row].title
        let author = episodes[indexPath.row].author
        let imageUrl = episodes[indexPath.row].imageUrl ?? ""
        return DownloadCellViewModel(title: title, author: author, imageUrl: imageUrl)
    }
    
    func fetchDownloadedEpisode(completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            completion(true)
        }
    }
}
