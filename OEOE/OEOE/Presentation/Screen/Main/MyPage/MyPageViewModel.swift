//
//  MyPageViewModel.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI

final class MyPageViewModel: ObservableObject {
    @Published var gender: String = ""
    @Published var age: String = ""
    @Published var style: String = ""

    init() {
        load()
    }

    func load() {
        if let data = UserDataManager.shared.loadOnboardingData() {
            gender = data.gender
            age = data.age
            style = data.style
        }
    }

    func update(
        key: SettingKey,
        value: String
    ) {
        switch key {
        case .gender:
            gender = value
        case .age:
            age = value
        case .style:
            style = value
        }

        // 저장 반영
        UserDataManager.shared.saveOnboardingData(
            gender: gender,
            age: age,
            style: style
        )
    }
    
    func options(for key: SettingKey) -> [String] {
        switch key {
        case .gender:
            return ["남자", "여자"]
        case .style:
            return FashionStyleType.allCases.map({ $0.displayName })
        case .age:
            return [] // age는 자유입력이라면 빈 배열
        }
    }

    func value(for key: SettingKey) -> String {
        switch key {
        case .gender:
            return gender
        case .age:
            return age
        case .style:
            return style
        }
    }

    enum SettingKey: String, CaseIterable, Identifiable {
        case gender = "성별"
        case age = "나이"
        case style = "스타일"
        
        var id: String { rawValue }
    }
}
