//
//  MyPageMainView.swift
//  Instageam4
//
//  Created by ASW-研修２ on 2020/05/11.
//  Copyright © 2020 ASW-研修２. All rights reserved.
//

import UIKit

import PGFramework
protocol MyPageMainViewDelegate: NSObjectProtocol{
    func profileButton()
}
extension MyPageMainViewDelegate {
}
// MARK: - Property
class MyPageMainView: BaseView {
    weak var delegate: MyPageMainViewDelegate? = nil
    @IBOutlet weak var profileButton: UIButton!
    @IBAction func profileButton(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.profileButton()
        }
    }
    @IBOutlet weak var userNameLabel: UILabel!
    
}
// MARK: - Life cycle
extension MyPageMainView {
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
    }
}
// MARK: - Protocol
extension MyPageMainView {
}

// MARK: - method
extension MyPageMainView {
    func setLayout() {
        profileButton.layer.borderWidth = 1
        profileButton.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        profileButton.layer.cornerRadius = 10
    }
    func getModel(userModel:UserModel) {
        userNameLabel.text = userModel.nickname
    }
}
