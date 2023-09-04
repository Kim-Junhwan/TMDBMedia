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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendListCollectionViewCell.identifier, for: indexPath) as? TrendListCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(media: trendList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        //detailViewController.movie = movieList.getMovieForIndex(index: indexPath.row)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
    
}
