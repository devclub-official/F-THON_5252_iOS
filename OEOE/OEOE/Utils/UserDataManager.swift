//
//  UserDataManager.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import Foundation

class UserDataManager {
    static let shared = UserDataManager()

    private let genderKey = "user_gender"
    private let ageKey = "user_age"
    private let styleKey = "user_style"

    func saveOnboardingData(
        gender: String,
        age: String,
        style: String
    ) {
        UserDefaults.standard.set(gender, forKey: genderKey)
        UserDefaults.standard.set(age, forKey: ageKey)
        UserDefaults.standard.set(style, forKey: styleKey)
    }

    func loadOnboardingData() -> OnboardingData? {
        guard
            let gender = UserDefaults.standard.string(forKey: genderKey),
            let age = UserDefaults.standard.string(forKey: ageKey),
            let style = UserDefaults.standard.string(forKey: styleKey)
        else {
            return nil
        }

        return OnboardingData(
            gender: gender,
            age: age,
            style: style
        )
    }

    func clear() {
        UserDefaults.standard.removeObject(forKey: genderKey)
        UserDefaults.standard.removeObject(forKey: ageKey)
        UserDefaults.standard.removeObject(forKey: styleKey)
    }
}
