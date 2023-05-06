//
//  EpisodeDetailViewViewModel.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/5/6.
//

import UIKit

class EpisodeDetailViewViewModel {
    private let endPointURL: URL?
    
    init(endPointUrl: URL?) {
        self.endPointURL = endPointUrl
        fetchEpisodeData()
    }
    
    private func fetchEpisodeData() {
        guard let url = endPointURL,
              let request = MERequest(url: url) else {
                  return
              }
        
        APIService.shared.execute(request, excepting: MEEpisode.self) { result in
            switch result {
            case .success(let success):
                print(String(describing: success))
            case .failure(let failure):                                                                                 
                break
            }
        }
    }
}
