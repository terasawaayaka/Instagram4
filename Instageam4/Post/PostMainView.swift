//
//  PostMainView.swift
//  Instageam4
//
//  Created by ASW-研修２ on 2020/05/07.
//  Copyright © 2020 ASW-研修２. All rights reserved.
//

import UIKit

import PGFramework
protocol PostMainViewDelegate: NSObjectProtocol{
}
extension PostMainViewDelegate {
    
}
// MARK: - Property
class PostMainView: BaseView {
    weak var delegate: PostMainViewDelegate? = nil
    @IBOutlet weak var descriptionLabel: UILabel!
    var postModel: PostModel = PostModel()
}
// MARK: - Life cycle
extension PostMainView {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
// MARK: - Protocol
extension PostMainView {
}

// MARK: - method
extension PostMainView {
    func getModel(postModel: PostModel) {
        updateCell(postModel: postModel) }
    func updateCell(postModel: PostModel) {
        descriptionLabel.text = postModel.description
    }
}
