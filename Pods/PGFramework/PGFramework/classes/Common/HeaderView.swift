//
//  HeaderView.swift
//
//  Created by Hiroki Umatani on 2020/01/08.
//  Copyright © 2020 Playground. All rights reserved.
//

import UIKit

// MARK: - Delegate
public protocol HeaderViewDelegate: NSObjectProtocol {

    /// 右のボタンが触られた時の処理
    /// - Parameter sender: 右ボタン
    func touchedLeftButton(_ sender: UIButton)

    /// 左ボタンが触られた時の処理
    /// - Parameter sender: 左ボタン
    func touchedRightButton(_ sender: UIButton)

    /// タイトルボタンが触られた時の処理
    /// - Parameter sender: タイトルボタン
    func touchedCenterButton(_ sender: UIButton)
}


extension HeaderViewDelegate {
    public func touchedLeftButton(_ sender: UIButton) {}
    public func touchedRightButton(_ sender: UIButton) {}
    public func touchedCenterButton(_ sender: UIButton) {}
}


// MARK: - Property
public class HeaderView: UIView {
    /// Header ViewのDelegate
    public weak var delegate: HeaderViewDelegate? = nil

    // outlet
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var rightButton: UIButton!

    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var leftButton: UIButton!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var centerImageView: UIImageView!
    @IBOutlet weak var underLine: UIView!

    @IBOutlet weak var centerButton: UIButton!
    var view: UIView?

    // action
    @IBAction func touchLeftButton(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.touchedLeftButton(sender)
        }
    }

    @IBAction func touchRightButton(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.touchedRightButton(sender)
        }
    }

    @IBAction func touchedCenterButton(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.touchedCenterButton(sender)
        }
    }
}

// MARK: - Life cycle
extension HeaderView {
    override open func awakeFromNib() {
        super.awakeFromNib()
        loadView()
        initTitleLabel()
        initUnderLine()
        initRightButton()
        initTitleLabel()
        initCenterButton()
    }
}

// MARK: - Protocol
extension HeaderView {

}

// MARK: - method
extension HeaderView {
    /// タイトルの文字の設定
    /// - Parameter text: タイトルの文字
    /// - Parameter fontSize: 文字のサイズ
    /// - Parameter color: 文字の色
    public func setCenter(text: String, fontSize: CGFloat? = nil, color: UIColor? = nil) {
        titleLabel.text = text
        titleLabel.isHidden = false

        if let fontSize = fontSize {
            titleLabel.font = UIFont.systemFont(ofSize: fontSize)
        }

        if let color = color {
            titleLabel.textColor = color
        }
    }

    /// タイトルの画像を設定
    /// - Parameter image: タイトルの画像
    public func setCenter(image: UIImage) {
        centerImageView.image = image
        centerImageView.isHidden = false
    }

    /// 左ボタンの文字の設定
    /// - Parameter text: ボタンの文字
    /// - Parameter fontSize: 文字のサイズ
    /// - Parameter color: 文字の色
    public func setLeft(text: String,
                        fontSize: CGFloat? = nil,
                        color: UIColor? = nil) {
        leftButton.setTitle(text, for: .normal)
        leftButton.isHidden = false

        if let fontSize = fontSize {
            leftButton.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        }

        if let color = color {
            leftButton.setTitleColor(color, for: .normal)
        }
    }

    /// 左ボタンの画像を設定
    /// - Parameter image: ボタンの画像
    public func setLeft(image: UIImage) {
        leftImageView.image = image
        leftButton.isHidden = false
        leftButton.setTitle(nil, for: .normal)
    }


    /// 右ボタンの文字の設定
    /// - Parameter text: ボタンの文字
    /// - Parameter fontSize: 文字のサイズ
    /// - Parameter color: 文字の色
    public func setRight(text: String,
                         fontSize: CGFloat? = nil,
                         color: UIColor? = nil) {
        rightButton.setTitle(text, for: .normal)
        rightButton.isHidden = false

        if let fontSize = fontSize {
            rightButton.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        }

        if let color = color {
            rightButton.setTitleColor(color, for: .normal)
        }
    }


    /// 右ボタンの画像を設定
    /// - Parameter image: ボタンの画像
    public func setRight(image: UIImage) {
        rightImageView.image = image
        rightButton.isHidden = false
        rightButton.setTitle(nil, for: .normal)
    }

    /// 背景の色を設定
    /// - Parameters:
    ///   - color: 背景の色
    ///   - alpha: 背景色の透明度
    public func setBackground(color: UIColor,
                              alpha: CGFloat? = nil) {

        guard let view = view else { return }
        view.backgroundColor = color

        guard let alpha = alpha else { return }
        view.alpha = alpha
    }

    /// 下線の色を設定
    /// - Parameters:
    ///   - color: 下線の色
    ///   - alpha: 色の透明度
    public func setUnderLine(color: UIColor,
                             alpha: CGFloat? = nil) {
        underLine.isHidden = false
        underLine.alpha = 1.0
        underLine.backgroundColor = color

        guard let alpha = alpha else { return }
        underLine.alpha = alpha
    }

    // Initial setting
    func initTitleLabel() {
        titleLabel.isHidden = true
    }

    func initLeftButton() {
        leftButton.isHidden = true
    }

    func initRightButton() {
        rightButton.isHidden = true
    }

    func initUnderLine() {
        underLine.isHidden = true
    }

    func initCenterButton() {
        centerButton.setTitle(nil, for: .normal)
    }

    func loadView() {
        let bundle = Bundle(for: type(of: self))
        view = bundle.loadNibNamed(className, owner: self, options: nil)!.first as? UIView

        guard let view = view else { return }

        view.frame = bounds
        view.autoresizingMask =
            [.flexibleHeight,
             .flexibleWidth]
        addSubview(view)
    }
}

