//
//  ProfileViewController.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/29.
//

import UIKit
import Photos

class ProfileViewController: BaseViewController {
    
    let profileView = ProfileView()
    let profileMenuList: [String] = ["이름","사용자 이름", "성별", "나이"]
    var defaultUserProfile: [String] = ["고양이","CAT","남","23"]
    
    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "프로필"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white.cgColor]
    }
    
    override func configureView() {
        profileView.tableView.delegate = self
        profileView.tableView.dataSource = self
        profileView.tableView.backgroundColor = .black
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        profileMenuList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier) as? ProfileTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.titleLabel.text = profileMenuList[indexPath.row]
        cell.subtitleLabel.text = defaultUserProfile[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProfileSettingViewController()
        vc.title = profileMenuList[indexPath.row]
        vc.textField.text = defaultUserProfile[indexPath.row]
        vc.setUserProfile = { settingProfile in
            self.defaultUserProfile[indexPath.row] = settingProfile
            tableView.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
