//
//  MenuTableViewCell.swift
//  PGFramework
//
//  Created by Hiroki Umatani on 2020/01/28.
//  Copyright © 2020 Playground. All rights reserved.
//

import UIKit


protocol MenuTableViewCellDelegate: NSObjectProtocol{

}

extension MenuTableViewCellDelegate {

}
// MARK: - Property
class MenuTableViewCell: BaseTableViewCell {
    weak var delegate: MenuTableViewCellDelegate? = nil
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var underLine: UIView!
}

// MARK: - Life cycle
extension MenuTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        underLine.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        underLine.alpha = 0.2
    }
}

// MARK: - Protocol
extension MenuTableViewCell {

}

// MARK: - method
extension MenuTableViewCell {

}
