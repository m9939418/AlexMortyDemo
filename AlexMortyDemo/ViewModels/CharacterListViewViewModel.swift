//
//  CharacterListViewViewModel.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/25.
//

import UIKit


final class CharacterListViewViewModel: NSObject {
    func fetchCharacters() {
        APIService.shared.execute(.listCharactersRequests, excepting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("image url " + String(model.results.first?.image ?? "NO IMAGE"))
                break
            case .failure(let error):
                String(describing: error)
                break
            }
        }
    }
}


extension CharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCollectionViewCell.cellId,
            for: indexPath
        ) as? CharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        let viewModel = CharacterCollectionViewCellViewModel(
            name: "Alex",
            status: .alive,
            imgUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        )
        cell.config(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width,
                      height: width * 1.5)
    }
}
