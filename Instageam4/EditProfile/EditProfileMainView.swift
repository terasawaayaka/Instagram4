//
//  EditProfileMainView.swift
//  Instageam4
//
//  Created by ASW-研修２ on 2020/05/11.
//  Copyright © 2020 ASW-研修２. All rights reserved.
//

import UIKit

import PGFramework
protocol EditProfileMainViewDelegate: NSObjectProtocol{
    func logoutButton()
}
extension EditProfileMainViewDelegate {
}
// MARK: - Property
class EditProfileMainView: BaseView {
    weak var delegate: EditProfileMainViewDelegate? = nil
    @IBOutlet weak var userNameTextField: UITextField!
    @IBAction func logoutButton(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.logoutButton()
        }
    }
}
// MARK: - Life cycle
extension EditProfileMainView {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
// MARK: - Protocol
extension EditProfileMainView {
}

// MARK: - method
extension EditProfileMainView {
    func updateView(userModel: UserModel) {
        userNameTextField.text = userModel.nickname
    }
}
