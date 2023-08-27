//
//  UserDefaultRepository.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/26.
//

import Foundation

struct UserDefaultRepository {
    
    static var isLaunched: Bool {
        get {
            UserDefaults.standard.bool(forKey: "isLaunched")
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isLaunched")
        }
    }
}
