//
//  AIView.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI

struct AIView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel: AIViewModel
    @State private var showMap = false

    var body: some View {
        VStack(spacing: 20) {
            // ✅ 현재 위치 텍스트
            Text("📍 현재 위치: \(viewModel.currentAddress)")
                .font(.headline)
                .padding(.top)

            // ✅ 목적지 입력 영역
            HStack {
                TextField("목적지를 선택하세요", text: $viewModel.destinationAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(true)

                Button(action: {
                    showMap = true
                }) {
                    Image(systemName: "globe")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(8)
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .sheet(isPresented: $showMap) {
            MapPickerView { coordinate in
                viewModel.setDestination(from: coordinate)
            }
        }
    }
}
