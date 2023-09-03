//
//  NetworkService.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/09/02.
//

import Foundation

enum NetworkError: Error {
    case responseError(statusCode: Int, data: Data?)
    case networkError(Error)
    case url
}

protocol NetworkService {
    func request(endPoint: Requestable ,completion: @escaping (Result<Data?, NetworkError>) -> Void)
}

final class DefaultNetworkService {
    
    private let config: NetworkConfiguration
    
    init(config: NetworkConfiguration) {
        self.config = config
    }
}

extension DefaultNetworkService: NetworkService {
    
    func request(endPoint: Requestable ,completion: @escaping (Result<Data?, NetworkError>) -> Void) {
        do {
            let request = try endPoint.makeURLRequest(networkConfig: config)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    if let response = response as? HTTPURLResponse {
                        completion(.failure(.responseError(statusCode: response.statusCode, data: data)))
                    } else {
                        completion(.failure(.networkError(error)))
                    }
                } else {
                    completion(.success(data))
                }
            }
        } catch {
            completion(.failure(.url))
        }
    }
    
    
}
