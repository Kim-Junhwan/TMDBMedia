//
//  DefaultTMDBRepository.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/09/02.
//

import Foundation

final class DefaultTMDBRepository {
    
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultTMDBRepository: TMDBRepository {
    func fetchTrendList(page: Int, completion: @escaping (Result<TrendPage, Error>) -> Void) {
        let endpoint = APIEndpoints.fetchTrendList(trendListRequestDTO: .init(page: page))
        dataTransferService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                completion(.success(data.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchDetailMedia(id: Int, completion: @escaping (Result<DetailMedia, Error>) -> Void) {
        let endpoint = APIEndpoints.fetchDetailMedia(detailReqeustDTO: .init(id: id))
        dataTransferService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                completion(.success(data.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
