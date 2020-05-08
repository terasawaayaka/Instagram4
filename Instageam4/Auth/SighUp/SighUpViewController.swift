//
//  SighUpViewController.swift
//  Instageam4
//
//  Created by ASW-研修２ on 2020/05/08.
//  Copyright © 2020 ASW-研修２. All rights reserved.
//

import UIKit

import PGFramework
// MARK: - Property
class SighUpViewController: BaseViewController {
    @IBOutlet weak var signUpMainView: SignUpMainView!
}
// MARK: - Life cycle
extension SighUpViewController {
    override func loadView() {
        super.loadView()
        setDelegate()
        
        tabBarController?.tabBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
// MARK: - Protocol
extension SighUpViewController:SignUpMainViewDelegate {
    func touchedSignUpButton() {
        let userModel: UserModel = UserModel()
        userModel.nickname = signUpMainView.userNameTextField.text
        userModel.mail = signUpMainView.emailTextField.text
        userModel.password = signUpMainView.passwordTextField.text
        UserModel.create(request: userModel, success: {
            let homeViewController = HomeViewController()
            self.navigationController?.pushViewController(homeViewController, animated: true)
            self.animatorManager.navigationType = .slide_push
        }) { (error) in
            print("SignUpエラー:",error)
        }
    }
}
// MARK: - method
extension SighUpViewController {
    func setDelegate() {
        signUpMainView.delegate = self
    }
}
