//
//  TVSeriesHeaderUICollectionReusableView.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/17.
//

import UIKit

class TVSeriesHeaderUICollectionReusableView: UICollectionReusableView, ReusableIdentifier {
    
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.adjustsFontSizeToFitWidth = true
    }
    
    func configureHeaderView(tvseries: TVSeries) {
        nameLabel.text = tvseries.name
        backdropImage.getImageFromUrl(posterPath: tvseries.backdropPath)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backdropImage.image = nil
    }
    
}
