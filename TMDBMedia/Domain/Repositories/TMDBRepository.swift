//
//  TrendRepository.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/09/02.
//

import Foundation

protocol TMDBRepository {
    func fetchTrendList(page: Int ,completion: @escaping (Result<TrendPage, Error>) -> Void)
    func fetchDetailMedia(id: Int ,completion: @escaping (Result<DetailMedia, Error>) -> Void)
    func fetchTVSeriesList(page: Int, completion: @escaping (Result<TVSeriesPage, Error>) -> Void)
    func fetchTVSeriesSeasonEpisode(tvSeriesId: Int, seasonNumber: Int ,completion: @escaping (Result<SeasonEpisodeList, Error>) -> Void)
}
