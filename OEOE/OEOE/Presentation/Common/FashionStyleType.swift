//
//  FashionStyleType.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

enum FashionStyleType: String, CaseIterable, Identifiable, Codable {
    case casual = "캐주얼"
    case minimal = "미니멀"
    case street = "스트릿"
    case vintage = "빈티지"
    case romantic = "로맨틱"
    case chic = "시크"
    case dandy = "댄디"

    var id: String { self.rawValue }

    var displayName: String {
        return self.rawValue
    }
}
