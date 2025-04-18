//
//  AIView.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI

struct AIView: View {
    @StateObject var viewModel: AIViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.desc)
                .font(.headline)
                .foregroundStyle(Color.red)
        }
        
    }
}
