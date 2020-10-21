//
//  Constants.swift
//  TinderClone
//
//  Created by Marko on 09/10/2020.
//  Copyright © 2020 Marko. All rights reserved.
//

import Foundation

struct K {
    struct Strings {
        static let email = "Email"
        static let fullName = "Full Name"
        static let password = "Password"
        static let login = "Log In"
        static let logout = "Log Out"
        static let register = "Register"
        static let signUp = "Sign Up"
        static let dontHaveAccount = "Don't have an account? "
        static let alreadyHaveAccount = "Already have an account? "
        static let cancel = "Cancel"
        static let done = "Done"
        static let settingsViewControllerTitle = "Settings"
        static let selectPhoto = "Select photo"
        static let savingData = "Saving data..."
        static let fetchingData = "Fetching data..."
        static let min = "Min"
        static let max = "Max"
        static let sendMessage = "Send Message"
        static let keepSwiping = "Keep Swiping"
        static let matchDescriptionLabel = "You and %@ have liked each other"
        static let newMatches = "New Matches"
        static let matches = "Matches"
    }
    struct UserDataParams {
        static let email = "email"
        static let fullName = "fullName"
        static let imageURLs = "imageURLs"
        static let uid = "uid"
        static let age = "age"
        static let minSeekingAge = "minSeekingAge"
        static let maxSeekingAge = "maxSeekingAge"
        static let profession = "profession"
        static let bio = "bio"
    }
    struct Error {
        static let avatarMissing = "Avatar needs to be added"
    }
    
    struct SettingsSections {
        static let name = "Name"
        static let profession = "Profession"
        static let age = "Age"
        static let bio = "Bio"
        static let ageRange = "Seaking Age Range"
    }
    
    struct Collection {
        static let users = "users"
        static let swipes = "swipes"
    }
    
}
