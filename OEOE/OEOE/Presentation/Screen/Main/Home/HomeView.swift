//
//  HomeView.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.desc)
                .font(.headline)
                .foregroundStyle(Color.red)
        }
        
    }
}
