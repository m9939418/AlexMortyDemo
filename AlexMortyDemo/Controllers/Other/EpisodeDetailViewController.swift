//
//  EpisodeDetailViewController.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/4/22.
//

import UIKit

/// VC show about single spisode
class EpisodeDetailViewController: UIViewController, RMEpisodeDetailViewViewModelDelegate, EpisodeDetailViewDelegate {
    
    private let viewModel: EpisodeDetailViewViewModel
    
    private let detailView = EpisodeDetailView()
    
    //MARK: - Init
    
    init(url: URL?){
//        self.viewModel = .init(endPointUrl: url)
        self.viewModel = EpisodeDetailViewViewModel(endPointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubViews(detailView)
        detailView.delegate = self
        addConstraints()
        title = "Episdoe"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        viewModel.delegates = self
        viewModel.fetchEpisodeData()
    }
 
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
        ])
    }
    
    @objc
    private func didTapShare() {
        
    }
    
    // MARK: - View Delegate
    
    func rmEpisodeDetailView(
        _ detailView: EpisodeDetailView,
        didSelect character: MECharacter
    ) {
        let vc = CharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - ViewModel Delegate
    
    func didFetchEpisodeDetails() {
        detailView.configure(with: viewModel)
    }
}
