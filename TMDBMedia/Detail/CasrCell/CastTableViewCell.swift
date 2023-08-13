//
//  CastTableViewCell.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/13.
//

import UIKit

class CastTableViewCell: UITableViewCell {
    
    static let identifier = "CastTableViewCell"

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 10.0
    }
    
    func configureCell(actor: Actor) {
        self.characterLabel.text = actor.character
        nameLabel.text = actor.name
        guard let profilePath = actor.profile_path else {
            profileImageView.image = UIImage(systemName: "person")
            return
        }
        profileImageView.getImageFromUrl(posterPath: profilePath)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
