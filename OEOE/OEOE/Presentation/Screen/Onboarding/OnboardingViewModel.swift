//
//  OnboardingViewModel.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var showGenderButtons = true
    @Published var showAgeInput = false
    @Published var showStyleSheet = false

    let fashionStyles = ["캐주얼", "미니멀", "스트릿", "빈티지", "로맨틱", "시크", "댄디"]

    init() {
        loadInitialMessages()
    }

    func loadInitialMessages() {
        messages = [
            ChatMessage(text: "안녕", isBot: true),
            ChatMessage(text: "너의 성별은 어떻게 되니?", isBot: true)
        ]
    }

    func addUserResponse(_ response: String) {
        messages.append(ChatMessage(text: response, isBot: false))

        if response == "남자" || response == "여자" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.messages.append(ChatMessage(text: "너의 나이는 어떻게 돼?", isBot: true))
                self.showGenderButtons = false
                self.showAgeInput = true
            }
        }
    }

    func submitAge(_ age: String) {
        messages.append(ChatMessage(text: age, isBot: false))
        showAgeInput = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.messages.append(ChatMessage(text: "원하는 스타일이 있어?", isBot: true))
            self.showStyleSheet = true
        }
    }

    func selectStyle(_ style: String) {
        messages.append(ChatMessage(text: style, isBot: false))
        showStyleSheet = false
    }
}
