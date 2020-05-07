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

class PostModel {
    fileprivate static let PATH: String = "post"
    var id : String = String()
    var description: String = String()
}
extension PostModel {
    static func parse(data: [String: Any]) -> PostModel {
        let model: PostModel = PostModel()
        if let id = data["id"] as? String {model.id = id}
        if let description = data["description"] as? String {model.description = description}
        return model
    }
}

extension PostModel {
    static func setParameter(request: PostModel) -> [String: Any] {
        var parameter: [String:Any] = [:]
        parameter["id"] = request.id
        parameter["description"] = request.description
        return parameter
    }
}

//MARK: - Create
extension PostModel {
    static func create(request: PostModel,success:@escaping() -> Void) {
        let dbRef = Database.database().reference().child(PATH).childByAutoId()
        if let key = dbRef.key {
            request.id = key
        }
        let parameter = setParameter(request: request)
        dbRef.setValue(parameter)
        success()
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

