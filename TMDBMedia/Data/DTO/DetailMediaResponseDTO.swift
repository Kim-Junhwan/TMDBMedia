//
//  DetailMediaResponseDTO.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/09/04.
//

import Foundation

struct DetailMediaResponseDTO: Decodable {
    let cast: [ActorDTO]
    
    func toDomain() -> DetailMedia {
        return DetailMedia(cast: cast.map { $0.toDomain() })
    }
}

struct ActorDTO: Decodable {
    let name: String
    let character: String
    let profile_path: String?
    
    func toDomain() -> Actor {
        return Actor(name: name, character: character, profile_path: profile_path)
    }
}
