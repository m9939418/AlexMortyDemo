//
//  MELocation.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/22.
//

import Foundation

struct MELocation: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
