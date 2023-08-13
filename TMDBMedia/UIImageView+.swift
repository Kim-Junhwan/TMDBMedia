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
        let url = "https://image.tmdb.org/t/p/original/\(posterPath)"
        AF.request(url, method: .get).validate().response { response in
            switch response.result {
            case .success(let value):
                guard let value else { return }
                DispatchQueue.main.async {
                    self.image = UIImage(data: value)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
