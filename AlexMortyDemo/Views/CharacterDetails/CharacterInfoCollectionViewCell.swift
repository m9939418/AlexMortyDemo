//
//  CharacterInfoCollectionViewCell.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/4/17.
//

import UIKit

final class CharacterInfoCollectionViewCell: UICollectionViewCell {
    static let cellID = "CharacterInfoCollectionViewCell"
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
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
    
    public func configure(with viewModel: CharacterInfoCollectionViewCellViewModel){
        
    }
}
