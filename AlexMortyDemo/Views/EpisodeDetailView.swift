//
//  EpisodeDetailView.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/5/6.
//

import UIKit

final class EpisodeDetailView: UIView {
    
    private var viewModel: EpisodeDetailViewViewModel?
    
    private var collectionView: UICollectionView?
    
    private var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .red
        self.collectionView = createCollectionView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    
    private  func addConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
    private func createCollectionView() -> UICollectionView {
        
        
    }
    
    // MARK: - Public
    
    public func configure(with viewModel: EpisodeDetailViewViewModel) {
        self.viewModel = viewModel
    }
}
