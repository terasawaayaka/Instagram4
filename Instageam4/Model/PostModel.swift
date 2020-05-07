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
    var id : String = String()
    var description: String = String()
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
        let dbRef = Database.database().reference().child("post").childByAutoId()
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
    
}

//MARK: - Update
extension PostModel {
    
}

//MARK: - Delete
extension PostModel {
    
}

