//
//  NetworkDefaultConfig.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/09/02.
//

import Foundation

struct NetworkConfiguration {
    var baseURL: URL
    var header: [String:String]
    var queryParameter: [String:String]
}

