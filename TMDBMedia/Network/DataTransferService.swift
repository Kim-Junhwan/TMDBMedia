//
//  DataTransferService.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/09/02.
//

import Foundation

enum DataTransferServiceError: Error {
    case parsing(error: Error)
    case noData
    case networkError(error: Error)
}

final class DataTransferService {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func request<T: Decodable, U: Networable>(endpoint: U, completion: @escaping (Result<T, DataTransferServiceError>) -> Void) where T == U.responseType {
        networkService.request(endPoint: endpoint) { result in
            switch result {
            case .success(let data):
                let fetchData: Result<T, DataTransferServiceError> = self.decode(data: data, decoder: endpoint.decoder)
                completion(fetchData)
            case .failure(let error):
                completion(.failure(.networkError(error: error)))
            }
        }
    }
    
    private func decode<T: Decodable>(data: Data?, decoder: ResponseDecoder) -> Result<T, DataTransferServiceError> {
        guard let data = data else { return .failure(.noData) }
        do {
            let decoding: T = try decoder.decode(data: data)
            return .success(decoding)
        } catch {
            return .failure(.parsing(error: error))
        }
        
    }
}
