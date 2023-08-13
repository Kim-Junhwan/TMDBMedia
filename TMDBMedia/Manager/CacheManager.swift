//
//  CacheManager.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/13.
//

import Foundation
import UIKit

struct CacheManager {
    
    private let cache = NSCache<NSString, UIImage>()
    
    static let shared = CacheManager()
    
    func getImage(path: String) -> UIImage? {
        if let cachedImage = cache.object(forKey: NSString(string: path)) {
            return cachedImage
        }
        return nil
    }
    
    func cacheImage(image: UIImage, path: String) {
        cache.setObject(image, forKey: NSString(string: path))
    }
}
