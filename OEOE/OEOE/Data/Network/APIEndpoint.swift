//
//  APIEndpoint.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

enum APIEndpoint {
    private static let baseURL = "baseURL"
    case api01
    case api02

    var urlString: String {
        var value: String
        switch self {
        case .api01:
            value = "/api01"
        case .api02:
            value = "/api02"
        }
        return APIEndpoint.baseURL + value
    }
}
