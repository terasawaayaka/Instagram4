//
//  EditViewController.swift
//  Instageam4
//
//  Created by ASW-研修２ on 2020/05/07.
//  Copyright © 2020 ASW-研修２. All rights reserved.
//

import UIKit

import PGFramework
// MARK: - Property
class EditViewController: BaseViewController {
    @IBOutlet weak var headerView: HeaderView!
    
    @IBOutlet weak var editMainView: EditMainView!
    var postModel: PostModel = PostModel()
}
// MARK: - Life cycle
extension EditViewController {
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
        giveModel()
    }
}
// MARK: - Protocol
extension EditViewController:HeaderViewDelegate {
    func touchedLeftButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func touchedRightButton(_ sender: UIButton) {
        if let text = editMainView.editTextField.text {
            postModel.description = text
        }
        PostModel.update(request: postModel) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
extension EditViewController: EditMainViewDelegate {
    func deleteButton() {
        PostModel.delete(id: postModel.id) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
}
// MARK: - method
extension EditViewController {
    func setHeaderView() {
        headerView.setLeft(text: "キャンセル", fontSize: 16, color: UIColor.blue)
        headerView.setCenter(text: "編集", fontSize: 19, color: UIColor.black)
        headerView.setRight(text: "完了", fontSize: 16, color: UIColor.blue)
    }
    func setDelegate() {
        headerView.delegate = self
        editMainView.delegate = self
    }
    func giveModel() {
        editMainView.updateView(postModel: postModel)
    }
}
