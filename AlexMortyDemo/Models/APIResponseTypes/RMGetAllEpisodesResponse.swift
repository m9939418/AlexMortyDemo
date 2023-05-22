//
//  RMGetAllEpisodesResponse.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/5/10.
//

import Foundation

struct RMGetAllEpisodesResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }

    let info: Info
    let results: [MEEpisode]
}
