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
    @Published var goHome: Bool = false
    @Published var isLoading = false
    
    @Published var gender: String = ""
    @Published var age: String = ""
    let fashionStyles = ["캐주얼", "미니멀", "스트릿", "빈티지", "로맨틱", "시크", "댄디"]

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

        if response == "남자" || response == "여자" {
            gender = response
            Task {
                try? await Task.sleep(nanoseconds: 500_000_000) // 0.5초
                await MainActor.run {
                    self.messages.append(ChatMessage(text: "나이는 어떻게 돼?", isBot: true))
                    self.showGenderButtons = false
                    self.showAgeInput = true
                }
            }
        }
    }

    func submitAge(_ input: String) {
        age = input
        messages.append(ChatMessage(text: input, isBot: false))
        showAgeInput = false

        Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            await MainActor.run {
                self.messages.append(ChatMessage(text: "원하는 스타일이 있어?", isBot: true))
                self.showStyleSheet = true
            }
        }
    }

    func selectStyle(_ style: String) {
        messages.append(ChatMessage(text: style, isBot: false))
        showStyleSheet = false

        Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            await MainActor.run {
                self.messages.append(ChatMessage(text: "🎉 모두 설정 완료!", isBot: true))
                self.messages.append(ChatMessage(text: "이제 너만을 위한 스타일 추천을 시작할게!", isBot: true))
                UserDataManager.shared.saveOnboardingData(
                    gender: self.gender,
                    age: self.age,
                    style: style
                )
            }
            
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            await MainActor.run {
                self.isLoading = true
            }
            
            try? await Task.sleep(nanoseconds: 5_000_000_000)
            await MainActor.run {
                self.isLoading = false
                self.goHome = true
            }
        }
    }
}
