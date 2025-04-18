//
//  SettingEditorView.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI

struct SettingEditorView: View {
    let title: String
    let currentValue: String
    let options: [String]
    let onSave: (String) -> Void

    @Environment(\.dismiss) var dismiss
    @State private var selected: String = ""
    @State private var inputText: String = ""

    var isFreeInput: Bool {
        options.isEmpty
    }

    var body: some View {
        NavigationView {
            Form {
                if isFreeInput {
                    TextField("\(title) 입력", text: $inputText)
                        .keyboardType(title == "나이" ? .numberPad : .default)
                } else {
                    ForEach(options, id: \.self) { option in
                        HStack {
                            Text(option)
                            Spacer()
                            if option == selected {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selected = option
                        }
                    }
                }
            }
            .navigationTitle(title)
            .navigationBarItems(
                leading: Button("취소") { dismiss() },
                trailing: Button("저장") {
                    let valueToSave = isFreeInput ? inputText : selected
                    onSave(valueToSave)
                    dismiss()
                }
                .disabled(isFreeInput ? inputText.isEmpty : selected.isEmpty)
            )
        }
        .onAppear {
            selected = currentValue
            inputText = currentValue
        }
    }
}
