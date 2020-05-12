//
//  SignInMainView.swift
//  Instageam4
//
//  Created by ASW-研修２ on 2020/05/11.
//  Copyright © 2020 ASW-研修２. All rights reserved.
//

import UIKit

import PGFramework
protocol SignInMainViewDelegate: NSObjectProtocol{
    func touchedSignInButton()
    func touchedSignUpButton()
}
extension SignInMainViewDelegate {
}
// MARK: - Property
class SignInMainView: BaseView {
    weak var delegate: SignInMainViewDelegate? = nil
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func touchedSignInButton(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.touchedSignInButton()
        }
    }
    @IBAction func touchedSignUpButton(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.touchedSignUpButton()
        }
    }
}
// MARK: - Life cycle
extension SignInMainView {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
// MARK: - Protocol
extension SignInMainView {
}

// MARK: - method
extension SignInMainView {
}
