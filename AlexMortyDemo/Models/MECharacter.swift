//
//  RMCharacter.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/22.
//

import Foundation

struct MECharacter: Codable {
    let id: Int
    let name: String
    let status: MECharacterStatus
    let species: String
    let type: String
    let gender: MECharacterGender
    let origin: MEOrigin
    let location: MESingleLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
