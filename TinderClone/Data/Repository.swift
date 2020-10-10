//
//  Repository.swift
//  TinderClone
//
//  Created by Marko on 09/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import Foundation
import Firebase

class Repository {
    
    private static var sharedRepository: Repository = {
        let repository = Repository()
        return repository
    }()
    
    private init() {
        
    }
    
    class func shared() -> Repository {
        return sharedRepository
    }
    
    func getCards() -> [CardView] {
        let user1 = User(name: "Jane Doe", age: 22, images: [#imageLiteral(resourceName: "lady5c"), #imageLiteral(resourceName: "kelly2")])
        let user2 = User(name: "Megan", age: 21, images: [#imageLiteral(resourceName: "jane1"), #imageLiteral(resourceName: "jane3")])
        
        let cardView1 = CardView(viewModel: CardViewModel(user: user1))
        let cardView2 = CardView(viewModel: CardViewModel(user: user2))
        
        return [cardView1, cardView2]
    }
    
    func registerUser(with credentials: AuthCredentials, completionHandler: @escaping (String?, Error?) -> Void) {
        AuthService.registerUser(with: credentials, completionHandler: completionHandler)
    }
    
    func logoutUser(completionHandler: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completionHandler(nil)
        } catch {
            completionHandler(error)
        }
    }
    
    func logUserIn(email: String, password: String,
                   completionHandler: @escaping (AuthDataResult?, Error?) -> Void) {
        AuthService.logUserIn(email: email, password: password, completionHandler: completionHandler)
    }
    
}
