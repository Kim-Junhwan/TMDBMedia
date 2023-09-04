//
//  DetailMovie.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/12.
//

import Foundation

struct DetailMedia {
    let cast: [Actor]
}

struct Actor: Decodable {
    let name: String
    let character: String
    let profile_path: String?
}
