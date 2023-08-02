//
//  RMLocationViewViewModel.swift
//  AlexMortyDemo
//
//  Created by Alex YANG 楊明仁 on 2023/8/1.
//

import Foundation


final class RMLocationViewViewModel {
    
    private var locations: [MELocation] = []
    
    private var cellViewModels: [String] = []
    
    
    init(){}
    
    public func fetchLocations() {
        let request = MERequest(endPoint: .location)
        APIService.shared.execute(.listLocationsRequests, excepting: String.self) { result in
            switch result {
            case .success(let model):
                break
            case .failure(let error):
                break
            }
        }
    }
    
    private var hasMoreResult: Bool {
        return false
    }
}

