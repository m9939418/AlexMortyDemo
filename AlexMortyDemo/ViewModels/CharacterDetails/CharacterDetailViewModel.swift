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
    
//    enum SectionType: CaseIterable {
    enum SectionType {
        case photo(viewModel: CharacterPhotoCollectionViewCellViewModel)
        
        case information(viewModels: [CharacterInfoCollectionViewCellViewModel])
        
        case episode(viewModels: [CharacterEpisodeCollectionViewCellViewModel])
    }
    
//    public let sections = SectionType.allCases
    public var sections:[SectionType] = []
    
    // MARK: - Init
    
    init(character: MECharacter){
        self.character = character
        setUpSections()
    }
    
    private func setUpSections() {
        /**
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
         */
        sections = [
            .photo(viewModel: .init(imageURL: URL(string: character.image))),
            .information(viewModels: [
                .init(type: .status, value: character.status.text),
                .init(type: .gender, value: character.gender.rawValue),
                .init(type: .type, value: character.type),
                .init(type: .species, value: character.species),
                .init(type: .origin, value: character.origin.name),
                .init(type: .location, value: character.location.name),
                .init(type: .created, value: character.created),
                .init(type: .episodeCount, value: "\(character.episode.count)"),
                
//                .init(value: character.status.text, title: "Status"),
//                .init(value: character.gender.rawValue, title: "Gender"),
//                .init(value: character.type, title: "Type"),
//                .init(value: character.species, title: "Species"),
//                .init(value: character.origin.name, title: "Origin"),
//                .init(value: character.location.name, title: "Location"),
//                .init(value: character.created, title: "Created"),
//                .init(value: "\(character.episode.count)", title: "Total Episode"),
            ]),
//            .episode(viewModels: [
//                .init(),
//                .init(),
//                .init(),
//                .init()
//            ])
            .episode(viewModels: character.episode.compactMap({
                return CharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: $0))
            }))

        ]
    }
    
    public var title:String {
        return character.name.uppercased()
    }
    
    public var requestUrl: URL? {
        return URL(string: character.url)
    }
    
//    public func fetchCharacterData() {
//        print(character.url)
//        guard let url = requestUrl,
//              let request = MERequest(url: url) else {
//
//                  return
//              }
//        APIService.shared.execute(request, excepting: MECharacter.self) { result in
//            switch(result) {
//            case .success(let success):
//                print(String(describing: success))
//            case .failure(let failure):
//                print(String(describing: failure))
//            }
//        }
//    }
    
    // MARK: - Layouts
    
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        /// 設定Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        /// 設定item 底部分隔線
        item.contentInsets = NSDirectionalEdgeInsets.init(
            top: 0,
            leading: 0,
            bottom: 10,
            trailing: 0
        )
        /// 設定Group
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)
            ),
            subitems: [item]
        )
        
        /// 設定Section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createInfoSectionLayout() -> NSCollectionLayoutSection {
        /// 設定Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        /// 設定item 底部分隔線
        item.contentInsets = NSDirectionalEdgeInsets.init(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2
        )
        /// 設定Group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item, item]
        )
        
        /// 設定Section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    
    public func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
        /// 設定Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        /// 設定item 底部分隔線
        item.contentInsets = NSDirectionalEdgeInsets.init(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10
        )
        /// 設定Group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        
        /// 設定Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
}
