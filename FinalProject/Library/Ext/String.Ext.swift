//
//  String.Ext.swift
//  FinalProject
//
//  Created by PCI0007 on 9/22/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

extension String {

    var httpsUrlString: String {
        contains("https") ? self : replacingOccurrences(of: "http", with: "https")
    }
}
