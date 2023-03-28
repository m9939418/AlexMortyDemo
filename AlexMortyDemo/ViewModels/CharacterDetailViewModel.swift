//
//  CharacterDetailViewModel.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/28.
//

import Foundation
import UIKit


/// 角色詳細頁ViewModel
final class CharacterDetailViewModel {
    private let character: MECharacter
    
    init(character: MECharacter){
        self.character = character
    }
    
    public var title:String {
        return character.name.uppercased()
    }
}
