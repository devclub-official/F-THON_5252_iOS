//
//  APIEndpoint.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

enum APIEndpoint {
    
    private static let baseURL = "http://3.15.6.33:8080/api"
    case postPopularLook
    case getPopularLook
    case postOutfitRequest

    var urlString: String {
        var value: String
        switch self {
        case .postPopularLook:
            value = "/popularLook"
        case .getPopularLook:
            value = "/popularLook"
        case .postOutfitRequest:
            value = "/outfitRequest"
        }
        return APIEndpoint.baseURL + value
    }
}
