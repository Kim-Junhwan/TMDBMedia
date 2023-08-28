//
//  TVSeriesCollectionViewCell.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/17.
//

import UIKit
import Alamofire

class TVSeriesCollectionViewCell: UICollectionViewCell, ReusableIdentifier {

    @IBOutlet weak var seasonNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var episodeList: EpisodeList = EpisodeList(episodes: [])
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: TVSeriesDetailSeasonCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TVSeriesDetailSeasonCollectionViewCell.identifier)
        
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.layoutIfNeeded()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: collectionView.frame.height * 1.5 , height: collectionView.frame.height)
        
        flowLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = flowLayout
    }
    
    func configureCell(season: Season, seasonId: Int) {
        seasonNameLabel.text = season.name
        AF.request("https://api.themoviedb.org/3/tv/\(seasonId)/season/\(season.seasonNumber)?api_key=\(APIKey.tmdsAPIKey)").validate().responseDecodable(of: EpisodeList.self) { response in
            guard let episodes = response.value else { return }
            self.episodeList = episodes
            self.collectionView.reloadData()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        episodeList = EpisodeList(episodes: [])
    }
}

extension TVSeriesCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodeList.episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVSeriesDetailSeasonCollectionViewCell.identifier, for: indexPath) as? TVSeriesDetailSeasonCollectionViewCell else { return TVSeriesCollectionViewCell() }
        cell.configureCell(episode: episodeList.episodes[indexPath.row])
        
        return cell
    }
    
    
}
