//
//  EpisodeDetailViewController.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/4/22.
//

import UIKit

/// VC show about single spisode
class EpisodeDetailViewController: UIViewController {
    private let viewModel: EpisodeDetailViewViewModel
    
    init(url: URL?){
        self.viewModel = .init(endPointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episdoe"
        view.backgroundColor = .systemGreen
    }
 
    
}
