//
//  CharacterDetailViewController.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/28.
//

import UIKit


/// 角色詳細頁
final class CharacterDetailViewController: UIViewController {
    private let viewModel: CharacterDetailViewModel
    private let detailView: CharacterDetailView
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        self.detailView = CharacterDetailView(frame: .zero,
                                              viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubViews(detailView)
        /// 新增『分享』按鈕
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self,
                                                            action: #selector(didTapShare))
        addConstraints()
        
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
    }
    
    @objc
    private func didTapShare() {
        // Shared character info
        print("click shared button")
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

// MARK: - CollectionView

extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch section {
//        case 0 :
//            return 1
//        case 1:
//            return 8
//        case 2:
//            return 20
//        default:
//            return 1
//        }
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .photo:
            return 1
        case .information(let viewModel):
            return viewModel.count
        case .episode(let viewModel):
            return viewModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        cell.backgroundColor = .systemPink
//        if indexPath.section == 0 {
//            cell.backgroundColor = .systemRed
//        } else if indexPath.section == 1 {
//            cell.backgroundColor = .systemCyan
//        } else {
//            cell.backgroundColor = .systemBlue
//        }
//        return cell
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterPhotoCollectionViewCell.cellID,
                for: indexPath) as? CharacterPhotoCollectionViewCell else {
                    fatalError()
                }
//            cell.backgroundColor = .systemRed
            cell.configure(with: viewModel)
            return cell
        case .information(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterInfoCollectionViewCell.cellID,
                for: indexPath) as? CharacterInfoCollectionViewCell else {
                    fatalError()
                }
            cell.backgroundColor = .systemCyan
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .episode(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterEpisodeCollectionViewCell.cellID,
                for: indexPath) as? CharacterEpisodeCollectionViewCell else {
                    fatalError()
                }
            cell.backgroundColor = .systemBlue
            cell.configure(with: viewModels[indexPath.row])
            return cell
        }
    }
}
