//
//  PostModel.swift
//  Instageam4
//
//  Created by ASW-研修２ on 2020/05/07.
//  Copyright © 2020 ASW-研修２. All rights reserved.
//

import UIKit
import PGFramework
import FirebaseDatabase
import FirebaseStorage

class PostModel {
    fileprivate static let PATH: String = "post"
    var id : String = String()
    var description: String = String()
    var image_paths : [String] = [String]()
    var post_user_name : String = String()
}
extension PostModel {
    static func parse(data: [String: Any]) -> PostModel {
        let model: PostModel = PostModel()
        if let id = data["id"] as? String {model.id = id}
        if let description = data["description"] as? String {model.description = description}
        if let post_user_name = data["post_user_name"] as? String {model.post_user_name = post_user_name}
        if let image_paths = data["image_paths"] as? [String] {model.image_paths = image_paths}
        return model
    }
}

extension PostModel {
    static func setParameter(request: PostModel) -> [String: Any] {
        var parameter: [String:Any] = [:]
        parameter["id"] = request.id
        parameter["description"] = request.description
        parameter["post_user_name"] = request.post_user_name
        parameter["image_paths"] = request.image_paths
        return parameter
    }
}

//MARK: - Create
extension PostModel {
    static func create(request: PostModel,images: [UIImage],success:@escaping() -> Void) {
        let dbRef = Database.database().reference().child(PATH).childByAutoId()
        if let key = dbRef.key {
            request.id = key
        }
        var parameter = setParameter(request: request)
        uploadPhoto(photoName: request.id, image: images, success: { (downloadPaths) in
            parameter["image_paths"] = downloadPaths
            dbRef.setValue(parameter)
            success()
        }) {
            print("写真アップロードエラー")
        }
    }
}
//MARK: - Read
extension PostModel {
    static func reads(success:@escaping ([PostModel]) -> Void) {
        let dbRef = Database.database().reference().child(PATH)
        dbRef.observe(.value, with: { snapshot in
            var models: [PostModel] = [PostModel]()
            for item in (snapshot.children) {
                let snapshot = item as! DataSnapshot
                let data = snapshot.value as! [String: Any]
                let model: PostModel = parse(data: data)
                model.id = snapshot.key
                models.append(model)
            }
            success(models)
        })
    }
    static func readAt(id: String,success:@escaping(PostModel) -> Void,failure:@escaping() -> Void) {
        let dbRef = Database.database().reference().child(PATH).child(id)
        dbRef.observe(.value) { (snapshot) in
            guard let data = snapshot.value as? [String: Any] else {
                failure()
                return
            }
            let model: PostModel = parse(data: data)
            success(model)
        }
    }
}

//MARK: - Update
extension PostModel {
    static func update(request: PostModel,success:@escaping() -> Void) {
        let id = request.id
        let dbRef = Database.database().reference().child(PATH).child(request.id)
        let parameter = setParameter(request: request)
        dbRef.updateChildValues(parameter) {(error,dbRef) in
            if error != nil {
                print("updateエラー:",error)
            } else {
                success()
            }
        }
    }

}

//MARK: - Delete
extension PostModel {
    static func delete(id: String,success:@escaping() -> Void) {
        let dbRef = Database.database().reference().child(PATH).child(id)
        dbRef.removeValue {(error,dbRef) in
            if error != nil {
                print("deleteエラー:",error)
            } else {
                success()
            }
        }
    }
}

extension PostModel {
    static func uploadPhoto(photoName: String, image: [UIImage]?, success: @escaping ([String]) -> Void, failure: @escaping () -> Void) -> Void{
        let group = DispatchGroup()
        let queue = DispatchQueue(label: ".photo")
        guard let images = image else {return}
        var num = 1
        var paths: [String] = []
        images.forEach { (image) in
            group.enter()
            queue.async {
                guard let data = image.jpegData(compressionQuality: 0.05), data.count < 4000000 else {
                    group.leave()
                    return failure()
                }
                let fileRef = Storage.storage().reference().child("images/" + photoName + num.description)
                num += 1
                let metaData = StorageMetadata()
                metaData.contentType = "image/jpeg"
                fileRef.putData(data, metadata: metaData) { (meta, error) in
                    fileRef.downloadURL { (url, error) in
                        if let _ = error {
                            return
                        } else {
                            paths.append(url?.description ?? "")
                            group.leave()
                        }
                    }
                }
            }
        }
        group.notify(queue: .main) {
            success(paths)
        }
    }

}
