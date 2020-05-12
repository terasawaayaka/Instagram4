//
//  SignInViewController.swift
//  Instageam4
//
//  Created by ASW-研修２ on 2020/05/11.
//  Copyright © 2020 ASW-研修２. All rights reserved.
//

import UIKit

import PGFramework
// MARK: - Property
class SignInViewController: BaseViewController {
    @IBOutlet weak var signInMainView: SignInMainView!
}
// MARK: - Life cycle
extension SignInViewController {
    override func loadView() {
        super.loadView()
        setDelegate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
// MARK: - Protocol
extension SignInViewController:SignInMainViewDelegate {
    func touchedSignInButton() {
        guard let mail = signInMainView.emailTextField.text else {return}
        guard let password = signInMainView.passwordTextField.text else {return}
        UserModel.signIn(email: mail, pass: password, failure: { (error) in
            print("SignInエラー:",error)
        }) {
            let homeViewController = HomeViewController()
            self.navigationController?.pushViewController(homeViewController, animated: true)
            self.animatorManager.navigationType = .pop
        }
    }
    func touchedSignUpButton() {
        let sighUpViewController = SighUpViewController()
        navigationController?.pushViewController(sighUpViewController, animated: true)
        animatorManager.navigationType = .slide_pop
    }
}
// MARK: - method
extension SignInViewController {
    func setDelegate() {
        signInMainView.delegate = self
    }
}
