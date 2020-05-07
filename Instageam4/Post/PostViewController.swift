//
//  PostViewController.swift
//  Instageam4
//
//  Created by ASW-研修２ on 2020/05/07.
//  Copyright © 2020 ASW-研修２. All rights reserved.
//

import UIKit

import PGFramework
// MARK: - Property
class PostViewController: BaseViewController {
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var postMainView: PostMainView!
    var postModel: PostModel = PostModel()
}
// MARK: - Life cycle
extension PostViewController {
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
        print("desc:",postModel.description)
        getModel()
    }
}
// MARK: - Protocol
extension PostViewController:HeaderViewDelegate {
    func touchedLeftButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        animatorManager.navigationType = .slide_pop
    }
    func touchedRightButton(_ sender: UIButton) {
        let editViewController = EditViewController()
        editViewController.postModel = postModel
        editViewController.modalPresentationStyle = .fullScreen
        present(editViewController,animated: true,completion: nil)
    }
}
// MARK: - method
extension PostViewController {
    func setHeaderView() {
        if let image = UIImage(named: "three") {
            headerView.setRight(image: image) }
        headerView.setLeft(text: "<", fontSize: 16, color: UIColor.blue)
        headerView.setCenter(text: "投稿詳細", fontSize: 19, color: UIColor.black)
    }
    func setDelegate() {
        headerView.delegate = self
    }
    func getModel() {
        self.postMainView.getModel(postModel: postModel)
        PostModel.readAt(id: postModel.id, success: { (postModel) in
            self.postModel = postModel
        }) {
            self.navigationController?.popViewController(animated: true)
            self.animatorManager.navigationType = .pop
        }
    }
}
