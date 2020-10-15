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
    
    func setSettingsData() {
        var data: [SettingsData] = []
        SettingsSections.allCases.forEach { section in
            let element = SettingsData(section: section)
            data.append(element)
        }
        settingsData.accept(data)
    }
    
}
