//
//  MyPageView.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI

struct MyPageView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel: MyPageViewModel
    @State private var selectedKey: MyPageViewModel.SettingKey?
    @State private var showEditor = false

    var body: some View {
        NavigationView {
            List {
                settingRow(.gender, value: viewModel.gender)
                settingRow(.age, value: viewModel.age)
                settingRow(.style, value: viewModel.style)
            }
            .navigationTitle("마이페이지")
            .sheet(item: $selectedKey) { key in
                SettingEditorView(
                    title: key.rawValue,
                    currentValue: viewModel.value(for: key),
                    options: viewModel.options(for: key),
                    onSave: { newValue in
                        viewModel.update(key: key, value: newValue)
                        appState.checkOnboarding()
                    }
                )
            }
        }
    }

    @ViewBuilder
    func settingRow(
        _ key: MyPageViewModel.SettingKey,
        value: String
    ) -> some View {
        HStack {
            Text(key.rawValue)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            selectedKey = key
            DispatchQueue.main.async {
                showEditor = true
            }
        }
    }
}
