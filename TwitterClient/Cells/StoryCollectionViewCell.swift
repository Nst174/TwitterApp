//
//  StoryCollectionViewCell.swift
//  TwitterClient
//
//  Created by 18574230 on 19.03.2021.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {

    var profileImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.layer.cornerRadius = 20
        img.clipsToBounds = true
        return img
    }()
    
    var profileName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 10)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(profileImage)
        contentView.addSubview(profileName)
        addConstraints()
    }
    
    private func addConstraints() {
        var constraint = [NSLayoutConstraint]()
        constraint.append(profileImage.widthAnchor.constraint(equalToConstant: 40))
        constraint.append(profileImage.heightAnchor.constraint(equalToConstant: 40))
        constraint.append(profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2.5))
        constraint.append(profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5))
        constraint.append(profileImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5))

        constraint.append(profileName.widthAnchor.constraint(equalToConstant: 50))
        constraint.append(profileName.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 5))
        constraint.append(profileName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5))
        constraint.append(profileName.bottomAnchor.constraint(equalTo: profileName.bottomAnchor, constant: -5))
        NSLayoutConstraint.activate(constraint)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
