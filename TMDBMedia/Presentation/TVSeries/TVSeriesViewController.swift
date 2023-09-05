//
//  TVSeriesViewController.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/17.
//

import UIKit
import Alamofire

class TVSeriesViewController: BaseViewController {

    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.register(UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionView.backgroundColor = .black
        return collectionView
    }()
    
    var isFetching = false
    var tvseriesList: [TVSeries] = []
    var repository: TMDBRepository
    var currentPage = 0
    var totalPage = 1
    var hasNextPage: Bool { currentPage < totalPage }
    var nextPage: Int {
        get {
            hasNextPage ? currentPage+1 : currentPage
        }
    }
    
    init(repository: TMDBRepository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        title = "TVSeries"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
        fetchTVSeries()
    }
    
    override func configureView() {
        view.addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func fetchTVSeries() {
        repository.fetchTVSeriesList(page: nextPage, completion: { [weak self] result in
            switch result {
            case .success(let tvSeries):
                self?.currentPage = tvSeries.page
                self?.totalPage = tvSeries.totalPages
                self?.tvseriesList.append(contentsOf: tvSeries.tvSeriesList)
                self?.collectionView.reloadData()
            case .failure(let failure):
                print(failure)
            }
        })
    }
    
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: TVSeriesHeaderUICollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TVSeriesHeaderUICollectionReusableView.identifier)
        
        collectionView.register(UINib(nibName: TVSeriesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TVSeriesCollectionViewCell.identifier)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        return tvseriesList.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvseriesList[section].seasons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVSeriesCollectionViewCell.identifier, for: indexPath) as? TVSeriesCollectionViewCell else { return UICollectionViewCell() }
        let tvSeriesSeason = tvseriesList[indexPath.section].seasons[indexPath.row]
        cell.configureCell(tvSeriesId: tvseriesList[indexPath.section].id, season: tvSeriesSeason, repository: repository)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TVSeriesHeaderUICollectionReusableView.identifier, for: indexPath) as? TVSeriesHeaderUICollectionReusableView else { return .init() }
        reusableView.configureHeaderView(tvseries: tvseriesList[indexPath.section])
        return reusableView
    }

}

extension TVSeriesViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >=  (scrollView.contentSize.height-(scrollView.frame.height-tabBarController!.tabBar.frame.height)) && !isFetching{
            fetchTVSeries()
        }
    }
    
}
