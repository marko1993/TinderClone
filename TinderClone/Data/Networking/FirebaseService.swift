//
//  FirebaseService.swift
//  TinderClone
//
//  Created by Marko on 10/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService: BaseService {
    
    static func saveUserData(user: User, completionHandler: @escaping (Error?) -> Void) {
        let data = getDataFromUser(user)
        getCollection(K.Collection.users).document(user.uid).setData(data, completion: completionHandler)
    }
    
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
    
    static func saveSwipe(for user: User, direction: SwipeDirection, completionHandler: ((Error?) -> Void)?) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        getCollection(K.Collection.swipes).document(uid).getDocument { snapshot, error in
            if error != nil {
                return
            }
            let data = [user.uid: direction == .right]
            if snapshot?.exists == true {
                getCollection(K.Collection.swipes).document(uid).updateData(data, completion: completionHandler)
            } else {
                getCollection(K.Collection.swipes).document(uid).setData(data, completion: completionHandler)
            }
        }
    }
    
    static func fetchUser(withUid uid: String, completionHandler: @escaping (User?, Error?) -> Void) {
        getCollection(K.Collection.users).document(uid).getDocument { snapshot, error in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            guard let data = snapshot?.data() else {return}
            completionHandler(User(data: data), nil)
        }
    }
    
    static func fetchUsers(forCurrentUser user: User, completionHandler: @escaping ([User]?, Error?) -> Void) {
        var users = [User]()
        
        let query = getCollection(K.Collection.users)
            .whereField(K.UserDataParams.age, isGreaterThanOrEqualTo: user.minSeekingAge)
            .whereField(K.UserDataParams.age, isLessThanOrEqualTo: user.maxSeekingAge)
        
        fetchSwipes { swipedUsers in
            query.getDocuments { (snapshot, error) in
                if let error = error {
                    completionHandler(nil, error)
                    return
                }
                snapshot?.documents
                    .map({ User(data: $0.data()) })
                    .filter({ $0.uid != user.uid && swipedUsers[$0.uid] == nil })
                    .forEach({ users.append($0) })
                
                completionHandler(users, nil)
            }
        }
    }
    
    private static func fetchSwipes(completionHandler: @escaping ([String: Bool]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        getCollection(K.Collection.swipes).document(uid).getDocument { snapshot, error in
            guard let data = snapshot?.data() as? [String: Bool]  else {
                completionHandler([String: Bool]())
                return
            }
            completionHandler(data)
        }
    }
    
    static func checkIfMatchExists(forUser user: User, completionHandler: @escaping (Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        getCollection(K.Collection.swipes).document(user.uid).getDocument { snapshot, error in
            guard let data = snapshot?.data() else { return }
            guard let didMatch = data[currentUid] as? Bool else { return }
            completionHandler(didMatch)
        }
    }
    
    private static func getDataFromUser(_ user: User) -> [String: Any] {
        return [K.UserDataParams.email: user.email,
                K.UserDataParams.fullName: user.name,
                K.UserDataParams.imageURLs: user.images,
                K.UserDataParams.uid: user.uid,
                K.UserDataParams.age: user.age,
                K.UserDataParams.profession: user.profession,
                K.UserDataParams.minSeekingAge: user.minSeekingAge,
                K.UserDataParams.maxSeekingAge: user.maxSeekingAge,
                K.UserDataParams.bio: user.bio] as [String : Any]
    }
    
}
