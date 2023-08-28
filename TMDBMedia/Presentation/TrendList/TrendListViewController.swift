//
//  TrendListViewController.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/11.
//

import UIKit
import Alamofire

class TrendListViewController: BaseViewController {
    
    let trendListView = TrendListView()

    
    var movieList: MovieList = MovieList(results: [])
    
    override func loadView() {
        view = trendListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func viewDidLayoutSubviews() {
        trendListView.setCollectionViewFlowlayout(numberOfLines: 1, inset: 20)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchMovieList()
    }
    
    override func configureView() {
        super.configureView()
        setNavigationBackButton()
        trendListView.collectionView.delegate = self
        trendListView.collectionView.dataSource = self
    }
    
    func fetchMovieList() {
        AF.request("https://api.themoviedb.org/3/trending/movie/day?api_key=\(APIKey.tmdsAPIKey)&language=ko-KR").responseDecodable(of: MovieList.self) { [weak self] response in
            guard let fetchList = response.value else { return }
            self?.movieList = fetchList
            self?.trendListView.collectionView.reloadData()
        }
    }
    
    func setNavigationBackButton() {
        let backButton = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
    
}

extension TrendListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendListCollectionViewCell.identifier, for: indexPath) as? TrendListCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(movie: movieList.getMovieForIndex(index: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = DetailViewController()
        detailViewController.movie = movieList.getMovieForIndex(index: indexPath.row)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
