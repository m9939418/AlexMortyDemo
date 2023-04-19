//
//  CharacterPhotoCollectionViewCellViewModel.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/4/17.
//

import Foundation

final class CharacterPhotoCollectionViewCellViewModel {
    private let imageURL: URL?
    
    init(imageURL: URL?) {
        self.imageURL = imageURL
    }
    
    public func fetchImage(comletion: @escaping (Result<Data,Error>) -> Void) {
        guard let imageUrl = imageURL else {
            comletion(.failure(URLError(.badURL)))
            return
        }
        MEImageLoader.shared.downloadImage(imageUrl, completeion: comletion)
    }
    
}
