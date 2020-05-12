//
//  EditProfileViewController.swift
//  Instageam4
//
//  Created by ASW-研修２ on 2020/05/11.
//  Copyright © 2020 ASW-研修２. All rights reserved.
//

import UIKit

import PGFramework
// MARK: - Property
class EditProfileViewController: BaseViewController {
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var editProfileMainView: EditProfileMainView!
    
    var userModel: UserModel = UserModel()
}
// MARK: - Life cycle
extension EditProfileViewController {
    override func loadView() {
        super.loadView()
        setHeaderView()
        setDelegate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        giveModel()
    }
}
// MARK: - Protocol
extension EditProfileViewController:HeaderViewDelegate {
    func touchedLeftButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func touchedRightButton(_ sender: UIButton) {
        if let text = editProfileMainView.userNameTextField.text {
            userModel.nickname = text
        }
        UserModel.update(request: userModel) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
extension EditProfileViewController:EditProfileMainViewDelegate {
    func logoutButton() {
        UserModel.logOut {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - method
extension EditProfileViewController {
    func setHeaderView() {
        headerView.setLeft(text: "キャンセル", fontSize: 16, color: UIColor.blue)
        headerView.setCenter(text: "プロフィール編集", fontSize: 19, color: UIColor.black)
        headerView.setRight(text: "完了", fontSize: 16, color: UIColor.blue)
    }
    func setDelegate() {
        headerView.delegate = self
        editProfileMainView.delegate = self
    }
    func giveModel() {
        editProfileMainView.updateView(userModel: userModel)
    }
}
