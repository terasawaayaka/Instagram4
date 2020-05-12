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
    
    @IBOutlet weak var postImageView: UIImageView!
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
        if let url = URL(string: postModel.image_paths[0]) {
            postImageView.af_setImage(withURL: url)
        }
    }
}
