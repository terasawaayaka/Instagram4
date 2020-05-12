//
//  MyPageViewController.swift
//  Instageam4
//
//  Created by ASW-研修２ on 2020/05/08.
//  Copyright © 2020 ASW-研修２. All rights reserved.
//

import UIKit

import PGFramework
import FirebaseAuth

// MARK: - Property
class MyPageViewController: BaseViewController {
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var myPageMainView: MyPageMainView!
    
    var userModel :UserModel = UserModel()
}
// MARK: - Life cycle
extension MyPageViewController {
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
        if Auth.auth().currentUser == nil {
            let sighUpViewController = SighUpViewController()
            navigationController?.pushViewController(sighUpViewController, animated: false)
        }
        getModel()
    }
}
// MARK: - Protocol
extension MyPageViewController:MyPageMainViewDelegate {
    func profileButton() {
        let editProfileViewController = EditProfileViewController()
        editProfileViewController.userModel = userModel
        editProfileViewController.modalPresentationStyle = .fullScreen
        present(editProfileViewController,animated: true,completion: nil)
    }
}
// MARK: - method
extension MyPageViewController {
    func setHeaderView() {
        headerView.setCenter(text: "MyPage", fontSize: 19, color: UIColor.black)
    }
    func setDelegate() {
        myPageMainView.delegate = self
        }
    func getModel() {
        self.myPageMainView.getModel(userModel: userModel)
        UserModel.readMe { (userModel) in
            self.userModel = userModel
            self.myPageMainView.getModel(userModel:userModel)
        }
    }
}
