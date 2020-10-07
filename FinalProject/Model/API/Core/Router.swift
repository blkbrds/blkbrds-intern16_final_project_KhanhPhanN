//
//  Router.swift
//  FinalProject
//
//  Created by MBA0176 on 4/24/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import Alamofire

final class Api {
    struct Path {
        static let baseURL = "https://itunes.apple.com"
    }
    
    struct Search { }
    
    struct Featured { }
    
    struct Episode { }
    
    struct Download { }
}

extension Api.Path {
    
    struct BaseDomain {
        static var path: String { return baseURL / "search" }
    }
    
    struct Featured {
        static var top20Url: String { return "https://itunes.apple.com/search?term=podcast&entity=podcast&limit=20" }
        static var educationUrl: String { return "1304" }
        static var societyUrl: String { return "1324" }
        static var musicUrl: String { return "1310" }
        static var newsUrl: String { return "1489" }
        static var sportUrl: String { return "1545" }
    }
}

protocol URLStringConvertible {
    var urlString: String { get }
}

extension URL: URLStringConvertible {
    var urlString: String { return absoluteString }
}

extension Int: URLStringConvertible {
    var urlString: String { return String(describing: self) }
}

private func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
    return lhs.urlString + "/" + rhs.urlString
}

extension String: URLStringConvertible {
    var urlString: String { return self }
}

extension CustomStringConvertible where Self: URLStringConvertible {
    var urlString: String { return description }
}
