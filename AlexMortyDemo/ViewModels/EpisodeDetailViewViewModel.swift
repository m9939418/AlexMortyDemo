//
//  EpisodeDetailViewViewModel.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/5/6.
//

import UIKit

protocol RMEpisodeDetailViewViewModelDelegate: AnyObject {
    func didFetchEpisodeDetails()
}


class EpisodeDetailViewViewModel {
    private let endPointURL: URL?
    private var dataTuple: (MEEpisode, [MECharacter])? {
        didSet {
            delegates?.didFetchEpisodeDetails()
        }
    }
    
    public weak var delegates: RMEpisodeDetailViewViewModelDelegate?
   
    // MARK: - init
    
    init(endPointUrl: URL?) {
        self.endPointURL = endPointUrl
//        fetchEpisodeData()
    }
    
    // MARK: Public
    
    
    // MARK: Private
    
    /// Fetch backing episode model
    public func fetchEpisodeData() {
        guard let url = endPointURL,
              let request = MERequest(url: url) else {
                  return
              }
        
        APIService.shared.execute(request, excepting: MEEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacters(episode: model)
            case .failure(let failure):                                                                                 
                break
            }
        }
    }
    
    private func fetchRelatedCharacters(episode: MEEpisode) {
        let requests: [MERequest] = episode.characters.compactMap({
            return URL(string: $0)
        }).compactMap({
            return MERequest(url: $0)
        })
        
        let group = DispatchGroup()
        var characters: [MECharacter] = []
        for request in requests {
            group.enter()
            APIService.shared.execute(request, excepting: MECharacter.self) { result in
                defer {
                    group.leave()
                }
                
                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure:
                    break
                }
            }
        }
        
        
        
    }
    
}
