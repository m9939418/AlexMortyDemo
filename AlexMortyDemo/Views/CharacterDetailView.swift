//
//  CharacterDetailView.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/28.
//

import UIKit


/// 角色詳細頁View
class CharacterDetailView: UIView {    
    public var collectionView: UICollectionView?
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let viewModel: CharacterDetailViewModel
    
    init(frame: CGRect, viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubViews(collectionView, spinner)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    private func addConstraints() {
        guard let collectionView = collectionView else {
            return
        }
        
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { selectionIndex,_ in
            return self.createSection(for: selectionIndex)
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
    private func createSection(for selectionIndex: Int) -> NSCollectionLayoutSection {
        let sectionTypes = viewModel.sections
        switch sectionTypes[selectionIndex] {
            case .photo:
                return createPhotoSectionLayout()
            case .information:
                return createInfoSectionLayout()
            case .episode:
                return createEpisodeSectionLayout()
        }
    }
    
//    public func configuration(viewModel: CharacterDetailViewModel) {
//        self.viewModel = viewModel
//    }
    func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        /// 設定Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        /// 設定item 底部分隔線
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0,
                                                             leading: 0,
                                                             bottom: 10,
                                                             trailing: 0)
        /// 設定Group
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        
        /// 設定Section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func createInfoSectionLayout() -> NSCollectionLayoutSection {
        /// 設定Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        /// 設定item 底部分隔線
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0,
                                                             leading: 0,
                                                             bottom: 10,
                                                             trailing: 0)
        /// 設定Group
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        
        /// 設定Section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    
    func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
        /// 設定Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        /// 設定item 底部分隔線
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0,
                                                             leading: 0,
                                                             bottom: 10,
                                                             trailing: 0)
        /// 設定Group
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        
        /// 設定Section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
