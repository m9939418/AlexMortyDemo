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
    
    enum SectionType: CaseIterable {
        case photo
        case information
        case episode
    }
    
    public let sections = SectionType.allCases
    
    // MARK: - Init
    
    init(character: MECharacter){
        self.character = character
    }
    
    public var title:String {
        return character.name.uppercased()
    }
    
    public var requestUrl: URL? {
        return URL(string: character.url)
    }
    
    public func fetchCharacterData() {
        print(character.url)
        guard let url = requestUrl,
              let request = MERequest(url: url) else {
                  
                  return
              }
        APIService.shared.execute(request, excepting: MECharacter.self) { result in
            switch(result) {
            case .success(let success):
                print(String(describing: success))
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    
}
