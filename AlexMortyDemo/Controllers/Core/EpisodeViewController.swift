//
//  EpisodeViewController.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/21.
//

import UIKit

/// Controller to show and search Episodes
class EpisodeViewController: UIViewController, EpisodeListViewDelegate {
 
    
    private let episodeListView = EpisodeListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "事件"
        setUpViews()
    }
    
    func setUpViews() {
        episodeListView.delegate = self
        view.addSubview(episodeListView)
        NSLayoutConstraint.activate([
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            episodeListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    ///MARK: - EpisodeListViewDelegate
    
    func rmEpisodeListView(_ characterListView: EpisodeListView, didSelectCharacter episode: MEEpisode) {
        ///Open detail controller for that episode
        let detailVC = EpisodeDetailViewController(url: URL(string: episode.url))
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
