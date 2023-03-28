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
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
