//
//  ContentView.swift
//  OEOE
//
//  Created by 송우진 on 4/18/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        if appState.isOnboarding {
            MainTabView()
        } else {
            OnboardingView()
        }
        
    }
}
