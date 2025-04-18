//
//  OEOEApp.swift
//  OEOE
//
//  Created by 송우진 on 4/18/25.
//

import SwiftUI

@main
struct OEOEApp: App {
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
