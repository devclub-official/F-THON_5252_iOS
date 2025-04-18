//
//  HomeViewModel.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    
    @Published var desc: String = ""
    @Published var testData: TestResponse?
    
    init() {
        desc = "HOME"
        
        Task {
            let data = await apiTest()
            
            await MainActor.run {
                testData = data
            }
        }
    }
    
    func apiTest() async -> TestResponse? {
        do {
            let response: Response<TestResponse> = try await APIClient.shared.requestDecodable(
                endpoint: .api01,
                method: .post,
                parameters: [
                    "params" : "aa"
                ]
            )
            return response.data
        } catch {
            Log.error(#function, error.localizedDescription)
            return nil
        }
    }
}
