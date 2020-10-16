//
//  SettingsSections.swift
//  TinderClone
//
//  Created by Marko on 13/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import Foundation

enum SettingsSection: Int, CaseIterable {
    case name
    case profession
    case age
    case bio
    case ageRange
    
    var description: String {
        switch self {
        case .name: return K.SettingsSections.name
        case .profession: return K.SettingsSections.profession
        case .age: return K.SettingsSections.age
        case .bio: return K.SettingsSections.bio
        case .ageRange: return K.SettingsSections.ageRange
        }
    }
    
}
