//
//  API.Featured.swift
//  FinalProject
//
//  Created by PCI0007 on 9/22/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import Alamofire

extension Api.Featured {
    
    static func fetchPodcasts(genreID: String?, completionHandler: @escaping ([Podcast]) -> Void) {
        
        var parameters = ["term": "podcast", "entity": "podcast", "limit": "20"]
        let urlString = Api.Path.BaseDomain.path
        
        if let genreID = genreID {
            parameters["genreId"] = genreID
        }
        
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
