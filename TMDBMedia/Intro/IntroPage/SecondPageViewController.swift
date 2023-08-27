//
//  SecondPageViewController.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/26.
//

import UIKit

class SecondPageViewController: UIViewController {

    let introCommentLabel: UILabel = {
       let label = UILabel()
        label.textColor = .red
        label.text = "아래 버튼을 클릭해서 메인 화면으로 이동⬇️"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 40)
        return label
    }()
    
    let mainViewButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "메인화면으로 이동"
        config.baseBackgroundColor = .black
        config.baseForegroundColor = .red
        let button = UIButton(configuration: config)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        return button
    }()
    
    let background: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "보노보노")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setView()
        mainViewButton.addTarget(self, action: #selector(displayMainView), for: .touchUpInside)
    }
    
    func setView() {
        view.addSubview(background)
        view.addSubview(introCommentLabel)
        view.addSubview(mainViewButton)
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        introCommentLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
        }
        mainViewButton.snp.makeConstraints { make in
            make.top.equalTo(introCommentLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func displayMainView() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MainTabBar")
        guard let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        let currentWindow = scene.window
        currentWindow?.rootViewController = vc
    }

}
