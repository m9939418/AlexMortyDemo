//
//  CharacterEpisodeCollectionViewCell.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/4/17.
//

import UIKit

final class CharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellID = "CharacterEpisodeCollectionViewCell"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBlue
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setUpConstraints() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: CharacterEpisodeCollectionViewCellViewModel){
        viewModel.registerForData { data in
            print(data.name)
            print(data.air_date)
            print(data.episode)
            
        }
        viewModel.fetchEpisode()
    }
}
