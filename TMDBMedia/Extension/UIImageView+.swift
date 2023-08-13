//
//  UIImageView+.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/12.
//

import Foundation
import UIKit
import Alamofire

extension UIImageView {
    func getImageFromUrl(posterPath: String) {
        if let cachedImage = CacheManager.shared.getImage(path: posterPath) {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            return
        }
        
        let url = "https://image.tmdb.org/t/p/original/\(posterPath)"
        AF.request(url, method: .get).validate().response { response in
            switch response.result {
            case .success(let value):
                guard let value else { return }
                DispatchQueue.main.async {
                    guard let downloadImage = UIImage(data: value) else { return }
                    CacheManager.shared.cacheImage(image: downloadImage, path: posterPath)
                    self.image = downloadImage
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
