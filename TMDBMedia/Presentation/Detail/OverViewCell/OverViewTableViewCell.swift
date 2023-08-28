//
//  OverViewTableViewCell.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/12.
//

import UIKit

class OverViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var overViewLabel: UILabel!
    static let identifier = "OverViewTableViewCell"
    var isOpen: Bool = false
    @IBOutlet weak var expandableButton: UIButton!
    lazy var overViewLabelHeightAnchor = overViewLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 100)

    override func awakeFromNib() {
        super.awakeFromNib()
        overViewLabelHeightAnchor.isActive = true
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isOpen {
            overViewLabelHeightAnchor.isActive = false
            expandableButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        } else {
            overViewLabelHeightAnchor.isActive = true
            expandableButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
        isOpen.toggle()
    }
    
    
}
