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
    @Published var isOnboarding: Bool = false
    @Published var onboardingData: OnboardingData?
    
    
    init() {
        checkOnboarding()
    }
    
    // 현재 탭 변경
    func changeTab(_ type: TabType) {
        selectedTab = type
    }
    
    // 온보딩에서 저장한 데이터를 기반으로 온보딩 여부 체크
    func checkOnboarding() {
        let data = UserDataManager.shared.loadOnboardingData()
        isOnboarding = (data != nil)
        onboardingData = data
    }
}
