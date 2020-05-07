//
//  BaseNavigationController.swift
//
//  Created by Hiroki Umatani on 2020/01/17.
//  Copyright © 2020 Playground. All rights reserved.
//

import UIKit

// MARK: - Property
open class BaseNavigationController: UINavigationController {

}

// MARK: - Life cycle
extension BaseNavigationController {
    open override func loadView() {
        super.loadView()
        isNavigationBarHidden = true
    }

    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - Protocol
extension BaseNavigationController {

}

// MARK: - Method
extension BaseNavigationController {

}

