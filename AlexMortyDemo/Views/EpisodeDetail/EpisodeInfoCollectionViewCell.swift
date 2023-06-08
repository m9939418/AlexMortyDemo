//
//  EpisodeInfoCollectionViewCell.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/5/31.
//

import UIKit

final class EpisodeInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "EpisodeInfoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpLayout() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: EpisodeInfoCollectionViewCellViewModel) {
        
    }
}
