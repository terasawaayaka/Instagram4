//
//  AutoScrollCollectionViewCell.swift
//  PGFramework
//
//  Created by Hiroki Umatani on 2020/01/31.
//  Copyright © 2020 Playground. All rights reserved.
//

import UIKit

protocol AutoCollectionViewCellDelegate: NSObjectProtocol {

}

extension AutoCollectionViewCellDelegate {

}
// MARK: - Property
class AutoCollectionViewCell: BaseCollectionViewCell {
    weak var delegate: AutoCollectionViewCellDelegate? = nil
    var autoScrollViewModelContetnts: AutoScrollViewModelContetnts = AutoScrollViewModelContetnts()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var leftMargin: NSLayoutConstraint!
    @IBOutlet weak var topMargin: NSLayoutConstraint!
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    @IBOutlet weak var rightMargin: NSLayoutConstraint!
}

// MARK: - Life cycle
extension AutoCollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Protocol
extension AutoCollectionViewCell {

}

// MARK: - method
extension AutoCollectionViewCell {
    func updateView(autoScrollViewModelContetnts: AutoScrollViewModelContetnts) {
        update(model: autoScrollViewModelContetnts)

        update(topMargin: topMargin, model: autoScrollViewModelContetnts)
        update(leftMargin: leftMargin, model: autoScrollViewModelContetnts)
        update(rightMargin: rightMargin, model: autoScrollViewModelContetnts)
        update(bottomMargin: bottomMargin, model: autoScrollViewModelContetnts)

        update(contentView: contentView, model: autoScrollViewModelContetnts)
        update(imageView: imageView, model: autoScrollViewModelContetnts)
        update(titleLabel: titleLabel, model: autoScrollViewModelContetnts)
        update(descriptionLabel: descriptionLabel, model: autoScrollViewModelContetnts)
    }

    private func update(model: AutoScrollViewModelContetnts) {
        self.autoScrollViewModelContetnts = model
    }

    private func update(contentView: UIView, model: AutoScrollViewModelContetnts) {
        contentView.backgroundColor = model.collectionViewCellBackgroundColor
    }

    private func update(imageView: UIImageView, model: AutoScrollViewModelContetnts) {
        let fetcher: Fetcher = Fetcher()
        if let image_url = model.image_url {
            fetcher.downloadImage(imageView: imageView, url: image_url)
        } else {
            imageView.image = nil
        }
    }

    private func update(leftMargin: NSLayoutConstraint, model: AutoScrollViewModelContetnts) {
        if let margin = model.cellMargin {
            leftMargin.constant = margin
        }
    }
    private func update(rightMargin: NSLayoutConstraint, model: AutoScrollViewModelContetnts) {
        if let margin = model.cellMargin {
            rightMargin.constant = margin
        }
    }
    private func update(topMargin: NSLayoutConstraint, model: AutoScrollViewModelContetnts) {
        if let margin = model.cellMargin {
            topMargin.constant = margin
        }
    }
    private func update(bottomMargin: NSLayoutConstraint, model: AutoScrollViewModelContetnts) {
        if let margin = model.cellMargin {
            bottomMargin.constant = margin
        }
    }

    private func update(titleLabel: UILabel, model: AutoScrollViewModelContetnts) {
        titleLabel.isHidden = model.isHiddenTitleLabel
        titleLabel.text = model.titleText
        if let color = model.titleLabelTextColor {
            titleLabel.textColor = color
        }

        if let fontSize = model.titleLabelFontSize {
            titleLabel.font = UIFont.systemFont(ofSize: fontSize)
        }
    }

    private func update(descriptionLabel: UILabel, model: AutoScrollViewModelContetnts) {
        descriptionLabel.isHidden = model.isHiddenDescriptionLabel
        descriptionLabel.text = model.descriptionText
        if let color = model.descriptionLabelTextColor {
            descriptionLabel.textColor = color
        }
        
        if let fontSize = model.descriptionLabelFontSize {
            descriptionLabel.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}

