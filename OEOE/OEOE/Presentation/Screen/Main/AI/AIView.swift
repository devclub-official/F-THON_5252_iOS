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
            Button("지도에서 위치 선택") {
                showMap = true
            }

            if let location = viewModel.selectedLocation {
                Text("선택한 위치: \(location.latitude), \(location.longitude)")
                    .padding()
            }
        }
        .sheet(isPresented: $showMap) {
            MapPickerView { coordinate in
                viewModel.selectedLocation = coordinate
            }
        }
    }
}
