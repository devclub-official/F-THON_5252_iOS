//
//  OnboardingView.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @State private var ageInput: String = ""

    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.messages) { message in
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
            }

            // 성별 선택 버튼
            if viewModel.showGenderButtons {
                HStack(spacing: 16) {
                    Button(action: {
                        viewModel.addUserResponse("남자")
                    }) {
                        Text("남자")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Button(action: {
                        viewModel.addUserResponse("여자")
                    }) {
                        Text("여자")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.pink)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }

            // 나이 입력 필드
            if viewModel.showAgeInput {
                HStack {
                    TextField("나이를 입력하세요", text: $ageInput)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)

                    Button("입력") {
                        if !ageInput.isEmpty {
                            viewModel.submitAge(ageInput)
                            ageInput = ""
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
        }
        .navigationTitle("온보딩")
    }
}
