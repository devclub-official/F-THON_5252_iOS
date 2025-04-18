//
//  OnboardingViewModel.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []

    init() {
        loadInitialMessages()
    }

    func loadInitialMessages() {
        messages = [
            ChatMessage(text: "안녕", isBot: true),
            ChatMessage(text: "너의 성별은 어떻게 되니?", isBot: true)
        ]
    }
}
