//
//  ProfileView.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/29.
//

import Foundation
import UIKit

class ProfileView: BaseView {
    let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "보노보노")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        return tableView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
    }
    
    override func configureView() {
        addSubview(profileImageView)
        addSubview(tableView)
        backgroundColor = .black
        tableView.backgroundView?.backgroundColor = .black
    }
    
    override func setConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(150)
            make.top.equalTo(snp.topMargin).offset(30)
        }
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(profileImageView.snp_bottomMargin).offset(20)
        }
    }
}
