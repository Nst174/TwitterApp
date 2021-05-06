//
//  PostTableViewCell.swift
//  TwitterClient
//
//  Created by OUT-Dobrolyubov1-NN on 18.03.2021.
//

import UIKit


class PostTableViewCell: UITableViewCell {
    var feed: PostModel? {
        didSet {
            guard let feedItem = feed else { return }
            if let name = feedItem.name {
                nameLabel.text = name
            }
            if let username = feedItem.username {
                profileImage.image = UIImage(named: username)
                usernameLabel.text = username
            }
            if let feed = feedItem.postText {
                feedTextLabel.text = feed
            }
        }
    }
    
    let containerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            return view
        }()
    
    let nameLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    let usernameLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 15)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    let profileImage: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 35
        return image
    }()
    
    let feedTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(profileImage)
        containerView.addSubview(nameLabel)
        containerView.addSubview(usernameLabel)
        containerView.addSubview(feedTextLabel)
        self.contentView.addSubview(containerView)
        
        profileImage.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        profileImage.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant:70).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.profileImage.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        usernameLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        usernameLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



