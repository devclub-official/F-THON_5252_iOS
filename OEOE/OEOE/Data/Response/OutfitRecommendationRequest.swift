//
//  OutfitRecommendationRequest.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

struct OutfitRecommendationRequest: Encodable {
    let gender: String
    let location: String
    let code: [String]
}
