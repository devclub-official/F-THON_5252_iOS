//
//  AppState.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//


import SwiftUI
import Combine

final class AppState: ObservableObject {
    @Published var selectedTab: TabType = .home
    
    
    init() {}
    
    // 현재 탭 변경
    func changeTab(_ type: TabType) {
        selectedTab = type
    }
}
