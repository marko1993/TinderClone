//
//  BaseService.swift
//  TinderClone
//
//  Created by Marko on 18/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class BaseService {
    func getCollection(_ name: String) -> CollectionReference {
        return Firestore.firestore().collection(name)
    }
}
