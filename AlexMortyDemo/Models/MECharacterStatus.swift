//
//  MECharacterStatus.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/22.
//

import Foundation

enum MECharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"

    var text: String {
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
