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
    var trendList: [Media] = []
    var currentPage = 0
    var totalPage = 1
    var hasNextPage: Bool { currentPage < totalPage }
    var nextPage: Int {
        get {
            hasNextPage ? currentPage+1 : currentPage
        }
    }
    var isFetching: Bool = false
    
    let repository: TMDBRepository
    
    init(repository: TMDBRepository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = trendListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .black
        title = "Trend List"
    }
    
    override func viewDidLayoutSubviews() {
        trendListView.setCollectionViewFlowlayout(numberOfLines: 1, inset: 20)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchTrendList()
    }
    
    override func configureView() {
        super.configureView()
        setNavigationBackButton()
        trendListView.collectionView.delegate = self
        trendListView.collectionView.dataSource = self
    }
    
    func fetchTrendList() {
        isFetching = true
        repository.fetchTrendList(page: nextPage) { [weak self] result in
            switch result {
            case .success(let trendPage):
                self?.currentPage = trendPage.page
                self?.totalPage = trendPage.totalPages
                self?.trendList.append(contentsOf: trendPage.mediaList)
                DispatchQueue.main.async {
                    self?.trendListView.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
            self?.isFetching = false
        }
    }
    
    func setNavigationBackButton() {
        let backButton = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
    
}

extension TrendListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let media = trendList[indexPath.row]        
        switch media.mediaType {
        case .movie:
            guard let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
            movieCell.configureCell(media: media)
            return movieCell
        case .tv:
            guard let tvCell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as? TVCollectionViewCell else { return UICollectionViewCell() }
            tvCell.configureCell(media: media)
            return tvCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.repository = repository
        detailViewController.media = trendList[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension TrendListViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >=  (scrollView.contentSize.height-(scrollView.frame.height-tabBarController!.tabBar.frame.height)) && !isFetching{
            fetchTrendList()
        }
    }
}
