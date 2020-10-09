//
//  HomeViewModel.swift
//  TinderClone
//
//  Created by Marko on 09/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit

class HomeViewModel: BaseViewModel {
    
    func getCards() -> [CardView] {
        return Repository.shared().getCards()
    }
    
}
