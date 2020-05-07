//
//  HomeTableViewCell.swift
//  Instageam4
//
//  Created by ASW-研修２ on 2020/05/07.
//  Copyright © 2020 ASW-研修２. All rights reserved.
//

import UIKit

import PGFramework
protocol HomeTableViewCellDelegate: NSObjectProtocol{
}
extension HomeTableViewCellDelegate {
}
// MARK: - Property
class HomeTableViewCell: BaseTableViewCell {
    weak var delegate: HomeTableViewCellDelegate? = nil
    @IBOutlet weak var descriptionLavel: UILabel!
}
// MARK: - Life cycle
extension HomeTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
// MARK: - Protocol
extension HomeTableViewCell {
}

// MARK: - method
extension HomeTableViewCell {
    func updateCell(postModel: PostModel) {
        descriptionLavel.text = postModel.description
    }
}
