//
//  CharacterInfoCollectionViewCellViewModel.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/4/17.
//

import Foundation

final class CharacterInfoCollectionViewCellViewModel {
    public let value: String
    public let title: String
    
    init(value: String, title: String) {
        self.value = value
        self.title = title
    }
    
}
