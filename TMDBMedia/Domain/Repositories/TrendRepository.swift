//
//  TrendRepository.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/09/02.
//

import Foundation

protocol TrendRepository {
    func fetchTrendList(page: Int ,completion: @escaping (Result<TrendPage, Error>) -> Void)
}
