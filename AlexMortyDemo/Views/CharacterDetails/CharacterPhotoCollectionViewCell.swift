//
//  CharacterPhotoCollectionViewCell..swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/4/17.
//

import UIKit

final class CharacterPhotoCollectionViewCell: UICollectionViewCell {
    static let cellID = "CharacterPhotoCollectionViewCell"
    
    private let ivImage: UIImageView = {
        let ivImage = UIImageView()
        ivImage.contentMode = .scaleAspectFit
        ivImage.clipsToBounds = true
        ivImage.translatesAutoresizingMaskIntoConstraints = false
        return ivImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubViews(ivImage)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            ivImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            ivImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            ivImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ivImage.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ivImage.image = nil
    }
    
    public func configure(with viewModel: CharacterPhotoCollectionViewCellViewModel){
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.ivImage.image = UIImage(data: data)
                }
            case .failure:
                break
            }
        }
    }
}
