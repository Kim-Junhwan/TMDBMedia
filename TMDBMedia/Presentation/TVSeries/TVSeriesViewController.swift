//
//  TVSeriesViewController.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/17.
//

import UIKit
import Alamofire

class TVSeriesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var tvseriesList: TVSeriesList = TVSeriesList()
    var sectionTVSeriesList: [Int:TVSeriesSeason] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        title = "TVSeries"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
        
        let group = DispatchGroup()
        group.enter()
        AF.request("https://api.themoviedb.org/3/tv/top_rated?api_key=\(APIKey.tmdsAPIKey)", method: .get).validate().responseDecodable(of: TVSeriesList.self) { [weak self] result in
            guard let list = result.value else { return }
            self?.tvseriesList = list
            for tvSeries in list.results {
                DispatchQueue.global().async {
                    group.enter()
                    AF.request("https://api.themoviedb.org/3/tv/\(tvSeries.id)?api_key=\(APIKey.tmdsAPIKey)&language=ko-KR").validate().responseDecodable(of: TVSeriesSeason.self) { response in
                        guard let fetchTvSeriesSeason = response.value else { return }
                        self?.sectionTVSeriesList[tvSeries.id] = fetchTvSeriesSeason
                        group.leave()
                    }
                }
            }
            group.leave()
        }
        group.notify(queue: .main) {
            self.collectionView.reloadData()
        }
    }
    
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: TVSeriesHeaderUICollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TVSeriesHeaderUICollectionReusableView.identifier)
        
        collectionView.register(UINib(nibName: TVSeriesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TVSeriesCollectionViewCell.identifier)
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.minimumLineSpacing = 8
        flowlayout.minimumInteritemSpacing = 8
        flowlayout.headerReferenceSize = CGSize(width: collectionView.frame.width, height: 100)
        flowlayout.itemSize = CGSize(width: collectionView.frame.width, height: 100)
        flowlayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 30, right: 0)
        flowlayout.scrollDirection = .vertical
        collectionView.collectionViewLayout = flowlayout
    }
    
}

extension TVSeriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tvseriesList.results.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionTVSeriesList[tvseriesList.results[section].id]?.seasons.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVSeriesCollectionViewCell.identifier, for: indexPath) as? TVSeriesCollectionViewCell else { return UICollectionViewCell() }
        let tvSeriesId = tvseriesList.results[indexPath.section].id
        guard let season = sectionTVSeriesList[tvSeriesId]?.seasons[indexPath.row] else { return UICollectionViewCell() }
        cell.configureCell(season: season, seasonId: tvSeriesId)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TVSeriesHeaderUICollectionReusableView.identifier, for: indexPath) as? TVSeriesHeaderUICollectionReusableView else { return .init() }
        reusableView.configureHeaderView(tvseries: tvseriesList.results[indexPath.section])
        return reusableView
    }

}
