//
//  StyleSelectionSheet.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI

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
                        .foregroundStyle(Color.primary)
                        .padding()
                }
            }
            .navigationTitle("스타일을 선택하세요")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
