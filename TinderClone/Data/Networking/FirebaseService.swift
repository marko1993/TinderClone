//
//  FirebaseService.swift
//  TinderClone
//
//  Created by Marko on 10/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import Foundation
import Firebase

struct FirebaseService {
    
    static func uploadImage(image: UIImage, completionHandler: @escaping (String?, Error?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(fileName)")
        ref.putData(imageData, metadata: nil) { metaData, error in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            ref.downloadURL { url, err in
                if let error = err {
                    completionHandler(nil, error)
                    return
                }
                guard let imageUrl = url?.absoluteString else {return}
                completionHandler(imageUrl, nil)
            }
        }
    }
    
    static func fetchUser(withUid uid: String, completionHandler: @escaping (User?, Error?) -> Void) {
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            guard let data = snapshot?.data() else {return}
            completionHandler(User(data: data), nil)
        }
    }
    
    static func fetchUsers(completionHandler: @escaping ([User]?, Error?) -> Void) {
        var users = [User]()
        
        Firestore.firestore().collection("users").getDocuments { (snapshot, error) in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            snapshot?.documents.forEach({ document in
                let data = document.data()
                let user = User(data: data)
                users.append(user)
            })
            completionHandler(users, nil)
        }
    }
    
}
