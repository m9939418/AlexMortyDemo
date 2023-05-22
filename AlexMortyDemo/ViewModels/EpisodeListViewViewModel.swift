//
//  EpisodeListViewViewModel.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/5/10.
//

import UIKit

protocol EpisodeListViewViewModelDelegate: AnyObject {
    func didLoadInitEpisodes()
    func didLoadMoreEpisodes(with newIndexPaths: [IndexPath])
    
    func didSelectEpisode(_ episdoe: MEEpisode)
}

/// ViewModel to handle episode listview logic
final class EpisodeListViewViewModel: NSObject {
    public weak var  delegate: EpisodeListViewViewModelDelegate?
    private var isLoadMoreEpisodes = false
    
    private let borderColors: [UIColor] = [
        .systemGreen,
        .systemBlue,
        .systemOrange,
        .systemPink,
        .systemPurple,
        .systemRed,
        .systemYellow
    ]
    
    private var episodes: [MEEpisode] = []{
        didSet {
            for episode in episodes {
                let vm = CharacterEpisodeCollectionViewCellViewModel(
                    episodeDataUrl: URL(string: episode.url),
                    borderColor: borderColors.randomElement() ?? .systemBlue
                )
                if !cellViewModels.contains(vm) {
                    cellViewModels.append(vm)
                }
            }
        }
    }
    
    private var cellViewModels: [CharacterEpisodeCollectionViewCellViewModel] = []
    
    private var apiInfo: RMGetAllEpisodesResponse.Info? = nil
    
    func fetchEpisodes() {
        APIService.shared.execute(
            .listEpisodesRequests,
            excepting: RMGetAllEpisodesResponse.self) { [weak self] result in
                switch result {
                case .success(let respModel):
                    let results = respModel.results
                    let info = respModel.info
                    self?.episodes = results
                    self?.apiInfo = info
                    DispatchQueue.main.async {
                        self?.delegate?.didLoadInitEpisodes()
                    }
                    break
                case .failure(let error):
                    print(String(describing: error))
                    break
                }
            }
    }
    
    ///Paginate if addtional episodes are need
    public func fetchMoreEpisodes(url: URL) {
        guard !isLoadMoreEpisodes else {
            return
        }
        isLoadMoreEpisodes = true
        print(String("Fetch more character"))
        guard let request = MERequest(url: url) else {
            isLoadMoreEpisodes = false
            print(String("Failed to create request"))
            return
        }
        APIService.shared.execute(request,
                                  excepting: RMGetAllEpisodesResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            switch result {
            case .success(let respModel):
                let moreResults = respModel.results
                let info = respModel.info
                strongSelf.apiInfo = info
                
                let orginCount = strongSelf.episodes.count
                let newCount = moreResults.count
                let total = orginCount + newCount
                let startIndex = total - newCount
                let indexPathsAdd: [IndexPath] = Array(startIndex..<(startIndex + newCount)).compactMap {
                    return IndexPath(row: $0, section: 0)   /// $0 ->  20
                }
                
                strongSelf.episodes.append(contentsOf: moreResults)
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreEpisodes(with: indexPathsAdd)
                    strongSelf.isLoadMoreEpisodes = false
                }
            case .failure(let failure):
                print(String(describing: failure))
                strongSelf.isLoadMoreEpisodes = false
            }
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
}

// MARK: - CollectionView

extension EpisodeListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterEpisodeCollectionViewCell.cellID,
            for: indexPath
        ) as? CharacterEpisodeCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = bounds.width - 20
        return CGSize(
            width: width,
            height: 100
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let selection = episodes[indexPath.row]
        delegate?.didSelectEpisode(selection)
    }

}


/// MARK: - ScrollView

/// 底部Load More Data
extension EpisodeListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadMoreEpisodes,
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
                self?.fetchMoreEpisodes(url: url)
            }
            t.invalidate()
        }
    }
}
