//
//  NewPostViewController.swift
//  Instageam4
//
//  Created by ASW-研修２ on 2020/05/07.
//  Copyright © 2020 ASW-研修２. All rights reserved.
//

import UIKit
import PGFramework
// MARK: - Property
class NewPostViewController: BaseViewController {
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var newPostMainView: NewPostMainView!
}
// MARK: - Life cycle
extension NewPostViewController {
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            newPostMainView.postImageView.image = image
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
// MARK: - Protocol
extension NewPostViewController:HeaderViewDelegate {
    func touchedLeftButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        animatorManager.navigationType = .slide_pop
    }
    func touchedRightButton(_ sender: UIButton) {
        let postModel: PostModel = PostModel()
        if let text = newPostMainView.textField.text {
            postModel.description = text
        }
        var images: [UIImage] = []
        if let image = newPostMainView.postImageView.image {
            images.append(image)
        }
        PostModel.create(request: postModel,images: images) {
            self.navigationController?.popViewController(animated: true)
            self.animatorManager.navigationType = .pop
        }
    }
}
extension NewPostViewController:NewPostMainViewDelegate {
    func touchedAddImageButton() {
        useCamera()
    }
}
// MARK: - method
extension NewPostViewController {
    func setHeaderView() {
        headerView.setLeft(text: "キャンセル", fontSize: 16, color: UIColor.blue)
        headerView.setCenter(text: "新規投稿", fontSize: 19, color: UIColor.black)
        headerView.setRight(text: "シェア", fontSize: 16, color: UIColor.blue)
    }
    func setDelegate() {
        headerView.delegate = self
        newPostMainView.delegate = self
    }
}
