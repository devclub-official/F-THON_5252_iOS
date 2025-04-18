//
//  OnboardingViewModel.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI

// MARK: - ViewModel
class OnboardingViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var showGenderButtons = true
    @Published var showAgeInput = false

    init() {
        loadInitialMessages()
    }

    func loadInitialMessages() {
        messages = [
            ChatMessage(text: "안녕", isBot: true),
            ChatMessage(text: "성별은 어떻게 되니?", isBot: true)
        ]
    }

    func addUserResponse(_ response: String) {
        messages.append(ChatMessage(text: response, isBot: false))

        if response == "여자" || response == "남자" {
            self.messages.append(ChatMessage(text: "나이는 어떻게 돼?", isBot: true))
            self.showGenderButtons = false
            self.showAgeInput = true
        }
    }

    func submitAge(_ age: String) {
        messages.append(ChatMessage(text: age, isBot: false))
        showAgeInput = false
        // 이어서 다음 질문 추가도 여기에 하면 됨
    }
}
