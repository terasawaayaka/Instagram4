//
//  AutoScrollViewModel.swift
//  PGFramework
//
//  Created by Hiroki Umatani on 2020/01/31.
//  Copyright © 2020 Playground. All rights reserved.
//

import UIKit

public class AutoScrollViewModel: NSObject {

    public var contents: [AutoScrollViewModelContetnts] = []
    public var settings: AutoScrollViewModelSettings = AutoScrollViewModelSettings()
}

public class AutoScrollViewModelSettings: NSObject {
    public var scrollAnimationTime: Double?
    public var collectionViewBackgroundColor: UIColor?
}

public class AutoScrollViewModelContetnts: NSObject {

    /// セルのイメージURL
    public var image_url: String?

    /// セルの背景色
    public var collectionViewCellBackgroundColor: UIColor?

    /// タイトルのテキスト
    public var titleText: String?
    public var isHiddenTitleLabel: Bool = true
    public var titleLabelTextColor: UIColor?
    public var titleLabelFontSize: CGFloat?

    /// 説明のテキスト
    public var descriptionText: String?
    public var isHiddenDescriptionLabel: Bool = true
    public var descriptionLabelTextColor: UIColor?
    public var descriptionLabelFontSize: CGFloat?

    /// セルのマージン
    public var cellMargin: CGFloat?
}
