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
    
    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.desc)
                .font(.headline)
                .foregroundStyle(Color.red)
            
            
            if let onboardingData = appState.onboardingData {
                VStack(spacing: 5) {
                    Text("성별: \(onboardingData.gender)")
                    Text("나이: \(onboardingData.age)세")
                    Text("스타일: \(onboardingData.style)")
                }
                .foregroundStyle(Color.green)
            }
            
            
        }
        
    }
}
