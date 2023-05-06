//
//  CharacterEpisodeCollectionViewCell.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/4/17.
//

import UIKit

final class CharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellID = "CharacterEpisodeCollectionViewCell"
    
    private let lSeason: UILabel = {
        let  label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let lName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let lAirDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.systemBlue.cgColor
        contentView.addSubViews(lSeason, lName, lAirDate)
        setUpConstraints()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            lSeason.topAnchor.constraint(equalTo: contentView.topAnchor),
            lSeason.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            lSeason.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            lSeason.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            lName.topAnchor.constraint(equalTo: lSeason.bottomAnchor),
            lName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            lName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            lName.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            lAirDate.topAnchor.constraint(equalTo: lName.bottomAnchor),
            lAirDate.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            lAirDate.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            lAirDate.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lSeason.text = nil
        lName.text = nil
        lAirDate.text = nil
    }
    
    public func configure(with viewModel: CharacterEpisodeCollectionViewCellViewModel){
        viewModel.registerForData { [weak self] data in
//            print(data.name)
//            print(data.air_date)
//            print(data.episode)
            // Main Queue
            self?.lSeason.text = data.episode
            self?.lName.text = "Episode " + data.name
            self?.lAirDate.text = "Aired on " + data.air_date
        }
        viewModel.fetchEpisode()
    }
}
