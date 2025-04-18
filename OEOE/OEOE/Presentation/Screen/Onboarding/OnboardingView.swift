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

            if viewModel.showGenderButtons {
                HStack(spacing: 16) {
                    Button("남자") {
                        viewModel.addUserResponse("남자")
                    }
                    .buttonStyle(GenderButtonStyle(color: .blue))

                    Button("여자") {
                        viewModel.addUserResponse("여자")
                    }
                    .buttonStyle(GenderButtonStyle(color: .pink))
                }
                .padding()
            }

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
        .sheet(isPresented: $viewModel.showStyleSheet) {
            StyleSelectionSheet(styles: viewModel.fashionStyles) { selectedStyle in
                viewModel.selectStyle(selectedStyle)
            }
        }
        .navigationTitle("온보딩")
    }
}

struct StyleSelectionSheet: View {
    let styles: [String]
    let onSelect: (String) -> Void

    var body: some View {
        NavigationView {
            List(styles, id: \.self) { style in
                Button(action: {
                    onSelect(style)
                }) {
                    Text(style)
                        .padding()
                }
            }
            .navigationTitle("스타일을 선택하세요")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct GenderButtonStyle: ButtonStyle {
    var color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
