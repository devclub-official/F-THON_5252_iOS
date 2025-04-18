//
//  HomeViewModel.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    
    @Published var desc: String = ""
    
    init() {
        desc = "HOME"
    }
}
