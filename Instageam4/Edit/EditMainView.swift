//
//  EditMainView.swift
//  Instageam4
//
//  Created by ASW-研修２ on 2020/05/07.
//  Copyright © 2020 ASW-研修２. All rights reserved.
//

import UIKit

import PGFramework
protocol EditMainViewDelegate: NSObjectProtocol{
    func deleteButton()
}
extension EditMainViewDelegate {
}
// MARK: - Property
class EditMainView: BaseView {
    weak var delegate: EditMainViewDelegate? = nil
    @IBOutlet weak var editTextField: UITextField!
    @IBAction func deleteButton(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.deleteButton()
        }
    }
}
// MARK: - Life cycle
extension EditMainView {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
// MARK: - Protocol
extension EditMainView {
}

// MARK: - method
extension EditMainView {
    func updateView(postModel: PostModel) {
        editTextField.text = postModel.description
    }
}
