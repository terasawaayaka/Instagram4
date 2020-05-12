//
//  NewPostMainView.swift
//  Instageam4
//
//  Created by ASW-研修２ on 2020/05/07.
//  Copyright © 2020 ASW-研修２. All rights reserved.
//

import UIKit

import PGFramework
protocol NewPostMainViewDelegate: NSObjectProtocol{
    func touchedAddImageButton()
}
extension NewPostMainViewDelegate {
}
// MARK: - Property
class NewPostMainView: BaseView {
    weak var delegate: NewPostMainViewDelegate? = nil
        
    @IBOutlet weak var textField: UITextField!
    @IBAction func touchedAddImageButton(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.touchedAddImageButton()
        }
    }
    
    @IBOutlet weak var postImageView: UIImageView!
}
// MARK: - Life cycle
extension NewPostMainView {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
// MARK: - Protocol
extension NewPostMainView {
}

// MARK: - method
extension NewPostMainView {
}
