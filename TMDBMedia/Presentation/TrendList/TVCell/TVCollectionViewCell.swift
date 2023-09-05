//
//  TVCollectionViewCell.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/09/05.
//

import UIKit

class TVCollectionViewCell: UICollectionViewCell {
    static let identifier = "TVCollectionViewCell"

    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var originNameLabel: UILabel!
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
    
    func configureCell(media: Media) {
        titleLabel.text = media.title
        ratingLabel.text = "\(media.voteCount)"
        releaseDateLabel.text = media.releaseDate
        originNameLabel.text = media.originalTitle
        languageLabel.text = media.originalLanguage
        thumbnailImageView.getImageFromUrl(posterPath: media.posterPath)
    }
}
