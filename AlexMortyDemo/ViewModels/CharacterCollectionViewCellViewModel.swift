//
//  CharacterCollectionViewCellViewModel.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/25.
//

import Foundation

final class CharacterCollectionViewCellViewModel {
    public let name: String
    public let status: MECharacterStatus
    public let imgUrl: URL?
    
    init(
        name: String,
        status: MECharacterStatus,
        imgUrl: URL?
    ) {
        self.name = name
        self.status = status
        self.imgUrl = imgUrl
    }
    
    public var statusString: String {
        return status.rawValue
    }
    
    public func fetchImage(completition: @escaping (Result<Data, Error>) -> Void) {
        // TODO: 
        guard let url = imgUrl else {
            completition(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completition(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completition(.success(data))
        }
        task.resume()
    }
}