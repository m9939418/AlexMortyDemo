//
//  MEEpisode.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/22.
//

import Foundation

struct MEEpisode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
