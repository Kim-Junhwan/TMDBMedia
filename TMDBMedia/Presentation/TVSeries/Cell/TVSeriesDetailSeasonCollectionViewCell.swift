//
//  TVSeriesDetailSeasonCollectionViewCell.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/17.
//

import UIKit

class TVSeriesDetailSeasonCollectionViewCell: UICollectionViewCell, ReusableIdentifier {

    @IBOutlet weak var stillPathimageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(episode: SeasonEpisode) {
        if let stillPath = episode.stillPath {
            stillPathimageView.getImageFromUrl(posterPath: stillPath)
        } else {
            stillPathimageView.image = UIImage(named: "ready")
        }
        
    }

}
