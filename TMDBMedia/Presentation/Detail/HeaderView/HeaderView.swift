//
//  HeaderView.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/28.
//

import Foundation
import UIKit

class HeaderView: BaseView {
    let backgroundImageView: UIImageView = {
       let imageView = UIImageView()
        
        return imageView
    }()
    
    let movieInfoStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 15
        return stackView
    }()
    
    let movieLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    
    let posterImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func configureView() {
        addSubview(backgroundImageView)
        addSubview(movieInfoStackView)
        movieInfoStackView.addArrangedSubview(movieLabel)
        movieInfoStackView.addArrangedSubview(posterImageView)
    }
    
    override func setConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        movieInfoStackView.snp.makeConstraints { make in
            make.bottom.equalTo(snp_bottomMargin).offset(-10)
            make.leading.equalTo(snp_leadingMargin).offset(40)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.snp.makeConstraints { make in
            make.width.equalTo(snp.width).multipliedBy(0.2)
            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.5)
        }
        
    }
}
