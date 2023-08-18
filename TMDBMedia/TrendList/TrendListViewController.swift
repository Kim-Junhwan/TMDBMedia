//
//  TrendListViewController.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/11.
//

import UIKit
import Alamofire

class TrendListViewController: UIViewController {
    
    private enum Metric {
        static let defaultInset: CGFloat = 20.0
    }

    @IBOutlet weak var collectionView: UICollectionView!
    var movieList: MovieList = MovieList(results: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        fetchMovieList()
        setNavigationBackButton()
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        setCollectionViewFlowlayout()
    }

    private func setCollectionView() {
        collectionView.register(UINib(nibName: TrendListCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TrendListCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    private func setCollectionViewFlowlayout() {
        let flowLayout = UICollectionViewFlowLayout()
        guard let windowWidth = view.window?.windowScene?.screen.bounds.width else { return }
        let width = windowWidth - (Metric.defaultInset * 2)
        flowLayout.itemSize = CGSize(width: width, height: width )
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        flowLayout.minimumLineSpacing = Metric.defaultInset
        collectionView.collectionViewLayout = flowLayout
    }
    
    func fetchMovieList() {
        AF.request("https://api.themoviedb.org/3/trending/movie/day?api_key=\(APIKey.tmdsAPIKey)&language=ko-KR").responseDecodable(of: MovieList.self) { response in
            guard let fetchList = response.value else { return }
                    self.movieList = fetchList
            self.collectionView.reloadData()
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
        guard let detailViewController = storyboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
        detailViewController.movie = movieList.getMovieForIndex(index: indexPath.row)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
