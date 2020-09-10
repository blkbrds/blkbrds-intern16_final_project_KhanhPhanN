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
        static let domain = "https://www.thesportsdb.com"
        static let baseURL = domain / "api" / "v1" / "json" / "1"
    }
    
    struct League { }
}

extension Api.Path {
    struct League {
        static var path: String { return baseURL }
        static var urlString: String { return Api.Path.League.path / "search_all_leagues.php" }
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
