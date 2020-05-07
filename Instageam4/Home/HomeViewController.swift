//
//  HomeViewController.swift
//  Instageam4
//
//  Created by ASW-研修２ on 2020/05/07.
//  Copyright © 2020 ASW-研修２. All rights reserved.
//

import UIKit

import PGFramework
// MARK: - Property
class HomeViewController: BaseViewController {
    @IBOutlet weak var headerView: HeaderView!
}
// MARK: - Life cycle
extension HomeViewController {
    override func loadView() {
        super.loadView()
        setHeaderView()
        setDelegate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
// MARK: - Protocol
extension HomeViewController:HeaderViewDelegate {
    func touchedRightButton(_ sender: UIButton) {
        //todo 新規投稿の遷移先
    }
}
// MARK: - method
extension HomeViewController {
    func setHeaderView() {
        headerView.setCenter(text: "Home", fontSize: 19, color: UIColor.black)
        headerView.setRight(text: "投稿", fontSize: 16, color: UIColor.blue)
    }
    func setDelegate() {
        headerView.delegate = self
    }
}
