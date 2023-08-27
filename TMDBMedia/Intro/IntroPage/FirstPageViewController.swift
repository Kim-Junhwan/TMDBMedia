//
//  FirstPageViewController.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/26.
//

import UIKit

class FirstPageViewController: UIViewController {
    
    let IntroCommentLabel: UILabel = {
       let label = UILabel()
        label.textColor = .red
        label.text = "환영합니다!"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        return label
    }()
    
    let background: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "보노보노")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserDefaultRepository.isLaunched = true
    }
    
    func setView() {
        view.addSubview(background)
        view.addSubview(IntroCommentLabel)
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        IntroCommentLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}
