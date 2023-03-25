//
//  CharacterCollectionViewCell.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/25.
//

import UIKit

final class CharacterCollectionViewCell: UICollectionViewCell {
    static let cellId = "CharacterCollectionViewCell"
    
    private let ivCover: UIImageView = {
        let ivCover = UIImageView()
        ivCover.contentMode = .scaleAspectFit
        ivCover.translatesAutoresizingMaskIntoConstraints = false
        return ivCover
    }()
    private let lbName: UILabel = {
        let lbName = UILabel()
        lbName.textColor = .label
        lbName.font = .systemFont(ofSize: 18,
                                  weight: .medium)
        lbName.translatesAutoresizingMaskIntoConstraints = false
        return lbName
    }()
    private let lbStatus: UILabel = {
        let lbName = UILabel()
        lbName.textColor = .secondaryLabel
        lbName.font = .systemFont(ofSize: 16,
                                  weight: .regular)
        lbName.translatesAutoresizingMaskIntoConstraints = false
        return lbName
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.addSubViews(ivCover, lbName, lbStatus)
        addConstraints()
    }
    

    override func prepareForReuse() {
        super.prepareForReuse()
        ivCover.image = nil
        lbName.text = nil
        lbStatus.text = nil
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            lbStatus.heightAnchor.constraint(equalToConstant: 50),
            lbName.heightAnchor.constraint(equalToConstant: 50),
            
            lbStatus.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            lbStatus.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            
            lbName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            lbName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            
            lbStatus.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            lbName.bottomAnchor.constraint(equalTo: lbStatus.topAnchor, constant: -3),
            
            ivCover.topAnchor.constraint(equalTo: contentView.topAnchor),
            ivCover.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            ivCover.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            ivCover.bottomAnchor.constraint(equalTo: lbName.topAnchor, constant: -3),
        ])
        
        ivCover.backgroundColor = .systemGreen
        lbName.backgroundColor = .blue
        lbStatus.backgroundColor = .orange
    }
    
    public func config(with viewModel: CharacterCollectionViewCellViewModel){
        lbName.text = viewModel.name
        lbStatus.text = viewModel.statusString
        viewModel.fetchImage { [weak self] reuslt in
            switch reuslt {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.ivCover.image = image
                }
                break
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
}
