//
//  CharacterViewController.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/21.
//

import UIKit

class CharacterViewController: UIViewController, CharacterListViewDelegate {
    private let characterListView = CharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "角色"
        setUpViews()
    }
    
    func setUpViews() {
        characterListView.delegate = self
        view.addSubview(characterListView)
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func rmCharacterListView(characterListView: CharacterListView, didSelectCharacter chartacter: MECharacter) {
        let viewModel = CharacterDetailViewModel(character: chartacter)
        let detailVC = CharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
