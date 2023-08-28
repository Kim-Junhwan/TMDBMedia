//
//  DetailViewController.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/12.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {
    
    let detailView: DetailView = DetailView()
    
    var movie: Movie?
    var detailMovie: DetailMovie?
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        getDetailMovie()
        title = "출연/제작"
        detailView.setHeaderView(movie: movie!)
    }
    
    func getDetailMovie() {
        guard let movie else { return }
        let url = "https://api.themoviedb.org/3/movie/\(movie.id)/credits?api_key=\(APIKey.tmdsAPIKey)"
        AF.request(url).response { response in
            
            switch response.result {
            case .success(let data):
                guard let data else { return }
                do {
                    let decodeData = try JSONDecoder().decode(DetailMovie.self, from: data)
                    self.detailMovie = decodeData
                    self.detailView.tableView.reloadData()
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func setTableView() {
        detailView.tableView.dataSource = self
        detailView.tableView.delegate = self
        detailView.tableView.register(UINib(nibName: OverViewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OverViewTableViewCell.identifier)
        detailView.tableView.register(UINib(nibName: CastTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CastTableViewCell.identifier)
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "OverView"
        } else {
            return "Cast"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return detailMovie?.cast.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverViewTableViewCell.identifier) as? OverViewTableViewCell else { return UITableViewCell() }
            cell.overViewLabel.text = movie?.overview
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as? CastTableViewCell, let detailMovie else { return UITableViewCell() }
            cell.configureCell(actor: detailMovie.cast[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
}
