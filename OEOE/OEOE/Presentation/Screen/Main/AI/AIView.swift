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

            Text("📍 현재 위치: \(viewModel.currentAddress)")
                .font(.headline)
                .padding(.top)

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
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.lookOptions.indices, id: \.self) { index in
                        let look = viewModel.lookOptions[index]

                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: viewModel.selectedLookIndex == index ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(viewModel.selectedLookIndex == index ? .blue : .gray)
                                Text("\(index + 1)번 코디")
                                    .font(.headline)
                                Spacer()
                            }

                            ForEach(look, id: \.self) { item in
                                Text("• \(item)")
                                    .font(.subheadline)
                                    .padding(.leading, 24)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .onTapGesture {
                            viewModel.selectedLookIndex = index
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showMap) {
            MapPickerView { coordinate in
                viewModel.setDestination(from: coordinate)
            }
        }
    }
}
