//
//  ProfileTableViewCell.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/29.
//

import UIKit
import SnapKit

class ProfileTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: ProfileTableViewCell.self)

    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    func configureView() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    
    func setConstraints() {
        subtitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(snp.width).multipliedBy(0.7)
            make.trailing.equalToSuperview().offset(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(snp.width).multipliedBy(0.2)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    

}
