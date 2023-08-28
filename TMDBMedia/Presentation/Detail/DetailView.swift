//
//  DetailView.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/28.
//

import Foundation
import UIKit

class DetailView: BaseView {

    let tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    lazy var headerView: HeaderView = HeaderView()
    
    override func configureView() {
        addSubview(tableView)
        tableView.tableHeaderView = headerView
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerView.snp.makeConstraints { make in
            make.height.equalTo(244)
            make.width.equalTo(snp.width)
        }
    }
    
    func setHeaderView(movie: Movie) {
        headerView.movieLabel.text = movie.title
        headerView.movieLabel.adjustsFontSizeToFitWidth = true
        headerView.backgroundImageView.getImageFromUrl(posterPath: movie.backdrop_path)
        headerView.posterImageView.getImageFromUrl(posterPath: movie.poster_path)
    }
    
}
