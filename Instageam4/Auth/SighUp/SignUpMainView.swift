//
//  SignUpMainView.swift
//  Instageam4
//
//  Created by ASW-研修２ on 2020/05/08.
//  Copyright © 2020 ASW-研修２. All rights reserved.
//

import UIKit

import PGFramework
protocol SignUpMainViewDelegate: NSObjectProtocol{
    func touchedSignUpButton()
}
extension SignUpMainViewDelegate {
}
// MARK: - Property
class SignUpMainView: BaseView {
    weak var delegate: SignUpMainViewDelegate? = nil
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func touchedSignUpButton(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.touchedSignUpButton()
        }
    }
}
// MARK: - Life cycle
extension SignUpMainView {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
// MARK: - Protocol
extension SignUpMainView {
}

// MARK: - method
extension SignUpMainView {
}
