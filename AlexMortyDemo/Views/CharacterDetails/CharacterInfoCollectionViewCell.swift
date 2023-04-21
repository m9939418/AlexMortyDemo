//
//  CharacterInfoCollectionViewCell.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/4/17.
//

import UIKit

final class CharacterInfoCollectionViewCell: UICollectionViewCell {
    static let cellID = "CharacterInfoCollectionViewCell"
 
    private let lValue: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Earth"
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    
    private let lTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Location"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let ivIcon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
//        iv.image = UIImage(systemName: "globe.americas")
        return iv
    }()
    
    private let vTitleContainer: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .tertiarySystemBackground
        return v
    }()
    
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubViews(vTitleContainer, lValue, ivIcon)
        vTitleContainer.addSubViews(lTitle)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            vTitleContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            vTitleContainer.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            vTitleContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            vTitleContainer.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            
            lTitle.topAnchor.constraint(equalTo: vTitleContainer.topAnchor),
            lTitle.leftAnchor.constraint(equalTo: vTitleContainer.leftAnchor),
            lTitle.rightAnchor.constraint(equalTo: vTitleContainer.rightAnchor),
            lTitle.bottomAnchor.constraint(equalTo: vTitleContainer.bottomAnchor),
            
            ivIcon.heightAnchor.constraint(equalToConstant: 30),
            ivIcon.widthAnchor.constraint(equalToConstant: 30),
            ivIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            ivIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            
            lValue.leftAnchor.constraint(equalTo: ivIcon.rightAnchor, constant: 10),
            lValue.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            lValue.topAnchor.constraint(equalTo: contentView.topAnchor),
//            lValue.heightAnchor.constraint(equalToConstant: 30)
            lValue.bottomAnchor.constraint(equalTo: vTitleContainer.topAnchor)
        ])
//        lValue.backgroundColor = .red
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lValue.text = nil
        lTitle.text = nil
        ivIcon.image = nil
        ivIcon.tintColor = .label
        lTitle.textColor = .label
    }
    
    public func configure(with viewModel: CharacterInfoCollectionViewCellViewModel){
        lTitle.text = viewModel.title
        lValue.text = viewModel.displayValue
        ivIcon.image = viewModel.iconImage
        ivIcon.tintColor = viewModel.tintColor
        lTitle.textColor = viewModel.tintColor
    }
}
