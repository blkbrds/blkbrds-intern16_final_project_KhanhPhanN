//
//  API.Search.swift
//  FinalProject
//
//  Created by PCI0007 on 9/22/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import Alamofire

extension Api.Search {
    
    static func searchPodcasts(searchText: String, completionHandler: @escaping ([Podcast]) -> Void) {
        let urlString = Api.Path.BaseDomain.path
        let parameters = ["term": searchText, "media": "podcast", "limit": "100"]
        
        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            
            if let err = dataResponse.error {
                print("Failed", err)
                return
            }
            guard let data = dataResponse.data else { return }
            do {
                let searchResult = try JSONDecoder().decode(PodcastResult.self, from: data)
                completionHandler(searchResult.results)
            } catch let decodeErr {
                print("Failed to decode:", decodeErr)
            }
        }
    }
}
