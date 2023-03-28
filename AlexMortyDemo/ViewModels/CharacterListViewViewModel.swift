//
//  CharacterListViewViewModel.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/25.
//

import UIKit

protocol CharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitCharacters()
    func didSelectCharacter(_ character: MECharacter)
}

final class CharacterListViewViewModel: NSObject {
    public weak var  delegate: CharacterListViewViewModelDelegate?
    
    private var characters: [MECharacter] = []{
        didSet {
            for character in characters {
                let vm = CharacterCollectionViewCellViewModel(
                    name: character.name,
                    status: character.status,
                    imgUrl: URL(string: character.image)
                )
                cellViewModels.append(vm)
            }
        }
    }
    
    private var cellViewModels: [CharacterCollectionViewCellViewModel] = []
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    
    func fetchCharacters() {
        APIService.shared.execute(
            .listCharactersRequests,
            excepting: RMGetAllCharactersResponse.self
        ) { [weak self]result in
            switch result {
            case .success(let respModel):
                let results = respModel.results
                let info = respModel.info
                self?.characters = results
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitCharacters()
                }
                break
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
    
    public func fetchMoreCharactoers() {
        
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
}


extension CharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCollectionViewCell.cellId,
            for: indexPath
        ) as? CharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.config(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width,
                      height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
}

extension CharacterListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator else {
            
            return
        }
    }
}
