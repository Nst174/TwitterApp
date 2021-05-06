//
//  StoriesCollectionViewCell.swift
//  TwitterClient
//
//  Created by OUT-Dobrolyubov1-NN on 19.03.2021.
//

import UIKit


class StoriesCollectionViewCell: UICollectionViewCell {
    var storie: StoriesModel?{
        didSet {
            guard let storieItem = storie else { return }
            if let image = storieItem.image {
                profileImage.image = image
            }
        }
    }
    
    let profileImage: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 35
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(profileImage)
        
        profileImage.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        profileImage.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant:70).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant:70).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
