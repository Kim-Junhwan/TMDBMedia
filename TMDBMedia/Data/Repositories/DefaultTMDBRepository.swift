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
        var tvSeriesPage: TVSeriesPage = .init(page: 0, totalPages: 0, tvSeriesList: [])
        let endpoint = APIEndpoints.fetchTVSeriesList(tvseriesListRequestDTO: .init(page: page))
        dataTransferService.request(endpoint: endpoint) { [weak self] result in
            switch result {
            case .success(let tvseriesList):
                for tvSeries in tvseriesList.tvSeriesList {
                    DispatchQueue.global().async {
                        group.enter()
                        self?.fetchTVSeriesSeasons(id: tvSeries.id, completion: { result in
                            switch result {
                            case .success(let data):
                                tvSeriesPage = TVSeriesPage(page: tvseriesList.page, totalPages: tvseriesList.totalPages, tvSeriesList: tvSeriesPage.tvSeriesList + [data])
                            case .failure(let error):
                                completion(.failure(error))
                            }
                            group.leave()
                        })
                    }
                    
                }
            case .failure(let error):
                completion(.failure(error))
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            completion(.success(tvSeriesPage))
        }
    }
    
    private func fetchTVSeriesSeasons(id: Int, completion: @escaping (Result<TVSeries,Error>) -> Void) {
        let endpoint = APIEndpoints.fetchTVSeriesSeason(tvSeriesSeasonsRequestDTO: .init(id: id))
        dataTransferService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                completion(.success(data.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTVSeriesSeasonEpisode(tvSeriesId: Int, seasonNumber: Int, completion: @escaping (Result<SeasonEpisodeList, Error>) -> Void) {
        let endpoint = APIEndpoints.fetchTvSeriesSeasonEpsode(tvSeriesSeasonEpsode: .init(tvSeriesId: tvSeriesId, seasonNumber: seasonNumber))
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
