//
//  AIViewModel.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI

final class AIViewModel: ObservableObject {
    
    @Published var desc: String = ""
    @Published var testData: TestResponse?
    
    
    init() {
        desc = "AI"
    }
    
    
}
