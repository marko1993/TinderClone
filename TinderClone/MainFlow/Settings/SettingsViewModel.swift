//
//  SettingsViewModel.swift
//  TinderClone
//
//  Created by Marko on 11/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SettingsViewModel: BaseViewModel {
    var settingsData: BehaviorRelay<[SettingsData]> = BehaviorRelay(value: [])
    var user: User?
    
    func setSettingsData() {
        var data: [SettingsData] = []
        getUser { [weak self] user, error in
            if let error = error {
                print(error)
                return
            }
            self?.user = user
            SettingsSections.allCases.forEach { section in
                let element = SettingsData(section: section, user: user!)
                data.append(element)
            }
            self?.settingsData.accept(data)
        }
        
    }
    
}
