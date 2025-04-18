//
//  OnboardingView.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = OnboardingViewModel()
    @State private var ageInput: String = ""

    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    ForEach(viewModel.messages) { message in
                        messageBubble(message)
                    }
                }

                if viewModel.showGenderButtons {
                    genderSelectionButtons
                }

                if viewModel.showAgeInput {
                    ageInputField
                }
                
            }
            
            if viewModel.isLoading {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("당신에게 딱 맞는 스타일을 찾고 있어요…")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.black.opacity(0.8))
                .cornerRadius(16)
            }
        }
        .onChange(of: viewModel.goHome) { _, newValue in
            if newValue {
                appState.isOnboarding = true
            }
        }
        .sheet(isPresented: $viewModel.showStyleSheet) {
            StyleSelectionSheet(styles: viewModel.fashionStyles) { selectedStyle in
                viewModel.selectStyle(selectedStyle)
            }
        }
    }

    // MARK: - 메시지 말풍선
    @ViewBuilder
    private func messageBubble(_ message: ChatMessage) -> some View {
        HStack {
            if message.isBot {
                Text(message.text)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
            } else {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal)
            }
        }
        .padding(.vertical, 4)
    }

    // MARK: - 성별 선택 버튼
    private var genderSelectionButtons: some View {
        HStack(spacing: 16) {
            genderButton(title: "남자")
            genderButton(title: "여자")
        }
        .padding()
    }

    private func genderButton(title: String) -> some View {
        Button(action: {
            viewModel.addUserResponse(title)
        }) {
            Text(title)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(hex: "#D9D9D9"))
                .foregroundColor(.black)
                .cornerRadius(10)
        }
    }

    // MARK: - 나이 입력 필드
    private var ageInputField: some View {
        HStack {
            TextField("나이를 입력하세요", text: $ageInput)
                .keyboardType(.numberPad)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            
            Button(action: {
                if !ageInput.isEmpty {
                    viewModel.submitAge(ageInput)
                    ageInput = ""
                }
            }) {
                Text("입력")
                    .foregroundColor(.black)
            }.padding(.horizontal)

        }
        .padding()
    }
}
