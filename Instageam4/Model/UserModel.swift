//
//  UserModel.swift
//  Instageam4
//
//  Created by ASW-研修２ on 2020/05/08.
//  Copyright © 2020 ASW-研修２. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
class UserModel{
    fileprivate static let PATH = "user"
    fileprivate static let photoSizeLimit = 4000000
    fileprivate static let photoCompressionRatio = 0.05
    static var DBRef: DatabaseReference!
    // parameters
    var id: String?
    var fcm_token: String?
    var mail: String?
    var password: String?
    var description: String?
    var nickname: String?
    var gender: String?
    var photo_path: String?
    var updated: Int? // firebaseではDate型保存不可のため、yyyyMMddHHmmssのIntとする。
}
// MARK: - Parse
extension UserModel {
    static func parse(data: [String: Any]) -> UserModel {
        let model = UserModel()
        model.id = data["id"] as? String
        model.mail = data["mail"] as? String
        model.password = data["password"] as? String
        model.description = data["description"] as? String
        model.nickname = data["nickname"] as? String
        model.gender = data["gender"] as? String
        model.photo_path = data["photo_path"] as? String
        model.updated = data["updated"] as? Int
        return model
    }
    static func setParameter(request: UserModel) -> [String: Any] {
        var parameter: [String: Any] = [:]
        if let id = request.id {parameter["id"] = id}
        if let mail = request.mail {parameter["mail"] = mail}
        if let password = request.password {parameter["password"] = password}
        if let description = request.description {parameter["description"] = description}
        if let nickname = request.nickname {parameter["nickname"] = nickname}
        if let fcm_token = request.fcm_token {parameter["fcm_token"] = fcm_token}
        if let gender = request.gender {parameter["gender"] = gender}
        if let photo_path = request.photo_path {parameter["photo_path"] = photo_path}
        if let updated = request.updated {parameter["updated"] = updated}
        return parameter
    }
}
// MARK: - Create
extension UserModel {
    // Authアカウント作成後、DBにアップする
    static func create(request: UserModel,
                       success:@escaping () -> Void, failure: @escaping ((String) -> Void)) {
        UserModel.signUp(email: request.mail ?? "", pass: request.password ?? "", failure: { (error) in
            failure(error)
        }) {
            guard let uid = Auth.auth().currentUser?.uid else {return failure("ユーザーが存在しません。")}
            DBRef = Database.database().reference().child(PATH).child(uid)
            let param = setParameter(request: request)
            DBRef.updateChildValues(param) { error, query in
                if let error = error {
                    failure(error.localizedDescription)
                } else {
                    success()
                }
            }
        }
    }
}
// MARK: - Reads
extension UserModel {
    static func reads(success:@escaping ([UserModel]) -> Void) {
        let DBRef = Database.database().reference().child(PATH)
        DBRef.observe(.value, with: { snapshot in
            var models: [UserModel] = [UserModel]()
            for item in (snapshot.children) {
                let snapshot = item as! DataSnapshot
                let data = snapshot.value as! [String: Any]
                let model: UserModel = parse(data: data)
                model.id = snapshot.key
                models.append(model)
            }
            success(models)
        })
    }
    static func readMe(success:@escaping (UserModel) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let DBRef = Database.database().reference().child(PATH).child(uid)
        DBRef.observe(.value, with: { snapshot in
            let snapshot = snapshot as DataSnapshot
            guard let data = snapshot.value as? [String: Any] else {return}
            let model: UserModel = parse(data: data)
            model.id = snapshot.key
            success(model)
        })
    }
    static func readAt(userId: String, success:@escaping (UserModel) -> Void) {
        let DBRef = Database.database().reference().child(PATH).child(userId)
        DBRef.observe(.value, with: { snapshot in
            guard let data = snapshot.value as? [String: Any] else {return}
            let model: UserModel = parse(data: data)
            model.id = snapshot.key
            success(model)
        })
    }
    static func readsOf(userIds: [String], success:@escaping ([UserModel]) -> Void) {
        var models = [UserModel]()
        let dispatchGroup = DispatchGroup()
        userIds.forEach { (userId) in
            dispatchGroup.enter()
            let DBRef = Database.database().reference().child(PATH).child(userId)
            DBRef.observeSingleEvent(of: .value, with: { snapshot in
                guard let data = snapshot.value as? [String: Any] else {return}
                let model: UserModel = parse(data: data)
                model.id = snapshot.key
                models.append(model)
                dispatchGroup.leave()
            })
        }
        dispatchGroup.notify(queue: .main) {
            success(models)
        }
    }
}
// MARK: - Update
extension UserModel {
    // Authアカウント作成を伴わない場合、createではなく下記を使用する。
    static func update(request: UserModel, image: UIImage?=nil,
                       success:@escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        DBRef = Database.database().reference().child(PATH).child(uid)
        var param = setParameter(request: request)
        if let image = image {
            uploadPhoto(image: image, success: { (downloadPath) in
                param["photo_path"] = downloadPath
                DBRef.updateChildValues(param) { error, query in
                    success()
                }
            }) {}
        } else {
            DBRef.updateChildValues(param) { (error, query) in
                success()
            }
        }
    }
    static func uploadPhoto(photoName:String?=nil, image: UIImage?, success: @escaping (String) -> Void, failure: @escaping () -> Void) -> Void{
        guard let image = image else {return}
        guard let uid = Auth.auth().currentUser?.uid else { return failure() }
        guard let data = image.jpegData(compressionQuality: CGFloat(photoCompressionRatio)), data.count < photoSizeLimit else {return failure()}
        let fileRef = Storage.storage().reference().child("images/" + uid)
        var imageRef = StorageReference()
        if let photoName = photoName {
            imageRef = fileRef.child(photoName)
        } else {
            imageRef = fileRef
        }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        imageRef.putData(data, metadata: metaData) { (meta, error) in
            imageRef.downloadURL { (url, error) in
                if let _ = error {
                    return
                } else {
                    success(url!.description)
                }
            }
        }
    }
}
extension UserModel {
    static func signUp(email: String, pass: String, failure:@escaping (String) -> Void, success:@escaping () -> Void){
        Auth.auth().createUser(withEmail: email, password: pass) { user, error in
            let token = UserDefaults.standard.object(forKey: "fcm_token") as? String
            let request = UserModel()
            request.fcm_token = token
            if let error = error {
                failure(error.localizedDescription)
            }
            if let _ = user {
                self.update(request: request, success: {})
                success()
            }
        }
    }
    static func signIn(email: String, pass: String, failure:@escaping (String) -> Void, success:@escaping () -> Void){
        Auth.auth().signIn(withEmail: email, password: pass) { user, error in
            let token = UserDefaults.standard.object(forKey: "fcm_token") as? String
            let request = UserModel()
            request.fcm_token = token
            if let error = error {
                failure(error.localizedDescription)
            }
            if let _ = user {
                self.update(request: request, success: {})
                success()
            }
        }
    }
    static func logOut(success: @escaping () -> Void) {
        do {
            try Auth.auth().signOut()
            success()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    static func delete(success: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userRef = Database.database().reference().child(PATH).child(uid)
        userRef.removeValue()
        let user = Auth.auth().currentUser
        user?.delete(completion: { (error) in
            if let error = error {
                print(error)
            } else {
                success()
            }
        })
    }
    // userIdからnicknameを取得する
    static func readNameOf(userId: String, success: @escaping((String) -> Void)) {
        let reference = Database.database().reference().child(PATH).child(userId).child("nickname")
        reference.observeSingleEvent(of: .value) { (snap) in
            guard let text = snap.value as? String else {return}
            success(text)
        }
    }
    // userIdからphoto_pathを取得する。
    static func readPathOf(userId: String, success: @escaping((String) -> Void)) {
        let reference = Database.database().reference().child(PATH).child(userId).child("photo_path")
        reference.observeSingleEvent(of: .value) { (snap) in
            guard let text = snap.value as? String else {return}
            success(text)
        }
    }
}

