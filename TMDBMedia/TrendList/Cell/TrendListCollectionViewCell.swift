//
//  TrendListCollectionViewCell.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/11.
//

import UIKit

class TrendListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TrendListCollectionViewCell"

    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var contentCellBackgroundView: UIView!
    
    @IBOutlet weak var contentCellView: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentCellView.layer.cornerRadius = 10.0
        contentCellView.backgroundColor = .systemBackground
        contentCellView.clipsToBounds = true
        contentCellBackgroundView.backgroundColor = .clear
        contentCellBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentCellBackgroundView.layer.shadowRadius = 5.0
        contentCellBackgroundView.layer.shadowColor = UIColor.black.cgColor
        contentCellBackgroundView.layer.shadowOpacity = 0.5
        clipsToBounds = false
    }
    
    func configureCell(movie: Movie) {
        releaseDateLabel.text = movie.release_date
        ratingLabel.text = String(movie.vote_count)
        titleLabel.text = movie.title
        languageLabel.text = movie.original_language
        thumbnailImageView.getImageFromUrl(posterPath: movie.poster_path)
    }

}
