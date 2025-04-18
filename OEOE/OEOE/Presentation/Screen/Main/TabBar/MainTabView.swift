//
//  MainTabView.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var appState: AppState
    var body: some View {
        TabView(selection: $appState.selectedTab) {
            HomeView(viewModel: HomeViewModel())
                .tabItem {
                    Image(systemName: "house.fill")
                    Text(TabType.home.title) 
                }
                .tag(TabType.home)
            
            AIView(viewModel: AIViewModel())
                .tabItem {
                    Image(systemName: "person.fill")
                    Text(TabType.ai.title)
                }
                .tag(TabType.ai)
        }
    }
}
