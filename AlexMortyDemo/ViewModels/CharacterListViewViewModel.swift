//
//  CharacterListViewViewModel.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/25.
//

import UIKit

protocol CharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitCharacters()
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath])
    func didSelectCharacter(_ character: MECharacter)
}

final class CharacterListViewViewModel: NSObject {
    public weak var  delegate: CharacterListViewViewModelDelegate?
    private var isLoadMoreCharacters = false
    
    private var characters: [MECharacter] = []{
        didSet {
            for character in characters where !cellViewModels.contains(where: { $0.name == character.name}){
                let vm = CharacterCollectionViewCellViewModel(
                    name: character.name,
                    status: character.status,
                    imgUrl: URL(string: character.image)
                )
                if !cellViewModels.contains(vm) {
                    cellViewModels.append(vm)
                }
            }
        }
    }
    
    private var cellViewModels: [CharacterCollectionViewCellViewModel] = []
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    
    func fetchCharacters() {
        APIService.shared.execute(
            .listCharactersRequests,
            excepting: RMGetAllCharactersResponse.self) { [weak self]result in
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
    
    public func fetchMoreCharactoers(url: URL) {
        guard !isLoadMoreCharacters else {
            return
        }
        isLoadMoreCharacters = true
        print(String("Fetch more character"))
        guard let request = MERequest(url: url) else {
            isLoadMoreCharacters = false
            print(String("Failed to create request"))
            return
        }
        APIService.shared.execute(request,
                                  excepting: RMGetAllCharactersResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            switch result {
            case .success(let respModel):
                let moreResults = respModel.results
                let info = respModel.info
                strongSelf.apiInfo = info
                
                let orginCount = strongSelf.characters.count
                let newCount = moreResults.count
                let total = orginCount + newCount
                let startIndex = total - newCount
                let indexPathsAdd: [IndexPath] = Array(startIndex..<(startIndex + newCount)).compactMap {
                    return IndexPath(row: $0, section: 0)   /// $0 ->  20
                }
                
                strongSelf.characters.append(contentsOf: moreResults)
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreCharacters(with: indexPathsAdd)
                    strongSelf.isLoadMoreCharacters = false
                }
            case .failure(let failure):
                print(String(describing: failure))
                strongSelf.isLoadMoreCharacters = false
            }
        }
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
    
    /// 設定Footer UI
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              shouldShowLoadMoreIndicator,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: FooterLoadingCollectionReusableView.cellId,
                for: indexPath
              ) as? FooterLoadingCollectionReusableView else {
                  fatalError()
              }
        footer.startAnimating()
        return footer
    }
    
    /// 設定Footer UI 高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width,
                      height: 100)
    }
}

/// 底部Load More Data
extension CharacterListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadMoreCharacters,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else {
                  return
              }
        Timer.scheduledTimer(withTimeInterval: 0.2,repeats: false) { [weak self] t in
            /// 偵測是否已經滑到列表底部
            let offset = scrollView.contentOffset.y
            let totoalContentHeight = scrollView.contentSize.height
            let totoalScrollViewFixHeight = scrollView.frame.size.height
            if offset >= (totoalContentHeight - totoalScrollViewFixHeight - 120 ) {
                //                print("Scroll Bottom End")
                self?.fetchMoreCharactoers(url: url)
            }
            t.invalidate()
        }
    }
}
