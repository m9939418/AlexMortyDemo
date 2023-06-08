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
    private var dataTuple: (episode: MEEpisode, characters: [MECharacter])? {
        didSet {
            createCellViewModels()
            delegates?.didFetchEpisodeDetails()
        }
    }
    
    enum SectionType {
        case information(viewModels: [EpisodeInfoCollectionViewCellViewModel])
        case characters(viewModels: [CharacterCollectionViewCellViewModel])
    }
    
    public weak var delegates: RMEpisodeDetailViewViewModelDelegate?
   
    public private(set) var ceilViewModels: [SectionType] = []
    
    // MARK: - init
    
    init(endPointUrl: URL?) {
        self.endPointURL = endPointUrl
//        fetchEpisodeData()
    }
    
    // MARK: Public
    
    
    // MARK: Private
    private func createCellViewModels() {
        guard let dataTuple = dataTuple else {
            return
        }

        let episode = dataTuple.episode
        let characters = dataTuple.characters
        ceilViewModels = [
            .information(viewModels: [
                .init(title: "Episdoe Name", value: episode.name),
                .init(title: "Air Date", value: episode.air_date),
                .init(title: "Episdoe", value: episode.episode),
                .init(title: "Created", value: episode.created),
            ]),
            .characters(viewModels: characters.compactMap({ characters in
                return CharacterCollectionViewCellViewModel(
                    name: characters.name,
                    status: characters.status,
                    imgUrl: URL(string: characters.image)
                )
            }))
        ]
    }
    
    
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
        group.notify(queue: .main) {
            self.dataTuple = (
                episode: episode,
                characters: characters
            )
        }
    }    
}
