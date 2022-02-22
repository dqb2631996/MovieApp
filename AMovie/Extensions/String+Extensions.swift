//
//  String+Extensions.swift
//  AMovie
//
//  Created by Mac on 2/21/22.
//  Copyright © 2022 identifier.demo.1. All rights reserved.
//

import Foundation

extension String {
    
    var mergeUrl: String {
        return URLs.imageBaseURL + self
    }
}
