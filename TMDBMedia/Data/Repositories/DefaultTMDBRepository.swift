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
    
    func fetchTVSeriesList(page: Int, completion: @escaping (Result<TVSeriesPage, Error>) -> Void) {
        let group = DispatchGroup()
        group.enter()
        let endpoint = APIEndpoints.fetchTVSeriesList(tvseriesListRequestDTO: .init(page: page))
        dataTransferService.request(endpoint: endpoint) { [weak self] result in
            switch result {
            case .success(let data):
                for tvSeries in data.tvSeriesList {
                    group.enter()
                    let tvSeriesPage = TVSeriesPage(page: data.page, totalPages: data.totalPages, tvSeriesList: [])
                    self?.fetchTVSeriesSeasons(tvSeriesPage: tvSeriesPage, group: group, id: tvSeries.id, completion: completion)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        group.leave()
    }
    
    private func fetchTVSeriesSeasons(tvSeriesPage: TVSeriesPage ,group: DispatchGroup ,id: Int, completion: @escaping (Result<TVSeriesPage,Error>) -> Void) {
        let endpoint = APIEndpoints.fetchTVSeriesSeason(tvSeriesSeasonsRequestDTO: .init(id: id))
        var tvSeriesList: [TVSeries] = []
        dataTransferService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                tvSeriesList.append(data.toDomain())
            case .failure(let error):
                completion(.failure(error))
            }
            group.leave()
        }
        group.notify(queue: .main) {
            completion(.success(.init(page: tvSeriesPage.page, totalPages: tvSeriesPage.totalPages, tvSeriesList: tvSeriesList)))
        }
    }
    
}
