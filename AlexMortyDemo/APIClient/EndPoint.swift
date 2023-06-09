//
//  EndPoint.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/21.
//

import Foundation


/// <#Description#>
enum EndPoint:String, Codable, CaseIterable, Hashable {
    case character
    case location
    case episode
}
