//
//  ProfileSettingViewController.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/30.
//

import UIKit

class ProfileSettingViewController: BaseViewController {
    
    lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(dismissView))
        return button
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.delegate = self
        return textField
    }()
    
    var setUserProfile: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    override func configureView() {
        view.addSubview(textField)
        navigationItem.setRightBarButton(doneButton, animated: true)
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    @objc func dismissView() {
        guard let setProfile = textField.text, let setUserProfile = self.setUserProfile else { return }
        setUserProfile(setProfile)
        navigationController?.popViewController(animated: true)
    }
    
}

extension ProfileSettingViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {return}
        if text.isEmpty {
            self.doneButton.isEnabled = false
        } else {
            self.doneButton.isEnabled = true
        }
    }
}
