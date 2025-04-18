//
//  MapPickerView.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI
import MapKit

struct MapPickerView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    let onSelect: (CLLocationCoordinate2D) -> Void

    var body: some View {
        NavigationView {
            VStack {
                MapKitView(selectedCoordinate: $selectedCoordinate)
                    .edgesIgnoringSafeArea(.all)
            }
            .navigationTitle("위치 선택")
            .navigationBarItems(trailing: Button("확인") {
                if let coord = selectedCoordinate {
                    onSelect(coord)
                    dismiss()
                }
            }.disabled(selectedCoordinate == nil))
        }
    }
}
