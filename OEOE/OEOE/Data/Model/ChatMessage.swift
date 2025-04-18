//
//  ChatMessage.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import Foundation

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isBot: Bool
}
