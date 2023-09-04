//
//  AppDIContainer.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/09/04.
//

import Foundation

final class AppDIContainer {
    
    private let tmdbConfig = NetworkConfiguration(baseURL: URL(string: "https://api.themoviedb.org")! , header: [:], queryParameter: ["language":"ko-KR","api_key":APIKey.tmdsAPIKey])
    
    lazy var tmdbRepository: TMDBRepository = {
       let repository = DefaultTMDBRepository(dataTransferService: tmdbDataTransferService)
        
        return repository
    }()
    
    private lazy var tmdbDataTransferService: DataTransferService = {
       let dataTransferService = DataTransferService(networkService: tmdbNetworkService)
        
        return dataTransferService
    }()
    
    private lazy var tmdbNetworkService: NetworkService = {
       let networkService = DefaultNetworkService(config: tmdbConfig)
        
        return networkService
    }()
}
