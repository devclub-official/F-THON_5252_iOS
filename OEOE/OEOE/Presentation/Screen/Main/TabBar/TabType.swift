//
//  TabType.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

enum TabType {
    case home
    case ai
    case my
    
    var title: String {
        switch self {
        case .home:
            return "HOME"
        case .ai:
            return "AI"
        case .my:
            return "My"
        }
    }
}
