//
//  TweetCell.swift
//  TwitterClient
//
//  Created by 18574230 on 12.03.2021.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
 
    var tweetDTO: Tweet? {
        didSet {
            userImage.image = tweetDTO?.userImage
            userNameLabel.text = tweetDTO?.userName
            userRealNameLabel.text = tweetDTO?.userRealName
            userMessageLabel.text = tweetDTO?.userMessage
            if tweetDTO?.messageImageName != nil {
                messageImageName.translatesAutoresizingMaskIntoConstraints = false
                messageImageName.image = UIImage(named: (tweetDTO?.messageImageName)!)
                
                NSLayoutConstraint.activate([messageImageName.heightAnchor.constraint(lessThanOrEqualTo: contentView.heightAnchor, multiplier: 0, constant: 50),
                     messageImageName.topAnchor.constraint(equalTo: userMessageLabel.bottomAnchor, constant: 5),
                     messageImageName.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 10),
                     messageImageName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                     commentButton.topAnchor.constraint(equalTo: messageImageName.bottomAnchor, constant: 5),
                     retweetButton.topAnchor.constraint(equalTo: messageImageName.bottomAnchor, constant: 5),
                     likeButton.topAnchor.constraint(equalTo: messageImageName.bottomAnchor, constant: 5),
                     forwardButton.topAnchor.constraint(equalTo: messageImageName.bottomAnchor, constant: 5)
                ])
                
                messageImageName.contentMode = .scaleAspectFill
                messageImageName.layer.cornerRadius = 10
                messageImageName.clipsToBounds = true
            }
            else {
                NSLayoutConstraint.activate([
                    commentButton.topAnchor.constraint(equalTo:  userMessageLabel.bottomAnchor, constant: 5),
                    retweetButton.topAnchor.constraint(equalTo: userMessageLabel.bottomAnchor, constant: 5),
                    likeButton.topAnchor.constraint(equalTo: userMessageLabel.bottomAnchor, constant: 5),
                    forwardButton.topAnchor.constraint(equalTo: userMessageLabel.bottomAnchor, constant: 5)])
            }
        }
    }
 
    private let userRealNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
 
 
    private let userMessageLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
 
    private let userImage : UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "camera.png"))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.layer.cornerRadius = 25
        imgView.clipsToBounds = true
        imgView.layer.borderColor = UIColor.black.cgColor
        imgView.layer.borderWidth = 1.0
        
        return imgView
    }()
    
    private let userNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .gray
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let messageImageName : UIImageView = {
        let imgView = UIImageView()
        
        return imgView
    }()
    
    private let commentButton : UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "comment.png"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitle(" 150", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    
    private let retweetButton : UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "retweet.png"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitle(" 200", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    
    private let likeButton : UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "like.png"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitle(" 300", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    
    private let forwardButton : UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "forward.png"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
 

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userImage)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(userRealNameLabel)
        contentView.addSubview(userMessageLabel)
        contentView.addSubview(commentButton)
        contentView.addSubview(retweetButton)
        contentView.addSubview(likeButton)
        contentView.addSubview(forwardButton)
        contentView.addSubview(messageImageName)
        addConstraints()
 
    }
 
    
    private func addConstraints() {
        var constraint = [NSLayoutConstraint]()
        
        constraint.append(userImage.widthAnchor.constraint(equalToConstant: 50))
        constraint.append(userImage.heightAnchor.constraint(equalToConstant: 50))
        constraint.append(userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10))
        constraint.append(userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15))

        constraint.append(userRealNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5))
        constraint.append(userRealNameLabel.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 10))

        constraint.append(userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5))
        constraint.append(userNameLabel.leftAnchor.constraint(equalTo: userRealNameLabel.rightAnchor, constant: 10))

        constraint.append(userMessageLabel.topAnchor.constraint(equalTo: userRealNameLabel.bottomAnchor, constant: 0))
        constraint.append(userMessageLabel.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 10))
        constraint.append(userMessageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10))
        
        constraint.append(commentButton.widthAnchor.constraint(equalToConstant: 45))
        constraint.append(commentButton.heightAnchor.constraint(equalToConstant: 16))
//        constraint.append(commentButton.imageView!.widthAnchor.constraint(equalToConstant: 45))
//        constraint.append(commentButton.imageView!.heightAnchor.constraint(equalToConstant: 16))
        constraint.append(commentButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3))
        constraint.append(commentButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 75))
        constraint.append(commentButton.imageView!.topAnchor.constraint(equalTo: commentButton.topAnchor, constant: 0))
        constraint.append(commentButton.titleLabel!.leftAnchor.constraint(equalTo: commentButton.imageView!.rightAnchor, constant: 0))

        constraint.append(retweetButton.widthAnchor.constraint(equalToConstant: 45))
        constraint.append(retweetButton.heightAnchor.constraint(equalToConstant: 16))
        constraint.append(retweetButton.leftAnchor.constraint(equalTo: commentButton.rightAnchor, constant: 15))
        
        constraint.append(retweetButton.imageView!.topAnchor.constraint(equalTo: retweetButton.topAnchor, constant: 0))
        constraint.append(retweetButton.titleLabel!.rightAnchor.constraint(equalTo: retweetButton.rightAnchor, constant: 0))
//        constraint.append(retweetButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3))
//        constraint.append(retweetButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5))

        constraint.append(likeButton.widthAnchor.constraint(equalToConstant: 45))
        constraint.append(likeButton.heightAnchor.constraint(equalToConstant: 16))
        constraint.append(likeButton.leftAnchor.constraint(equalTo: retweetButton.rightAnchor, constant: 15))
        
        constraint.append(likeButton.imageView!.topAnchor.constraint(equalTo: likeButton.topAnchor, constant: 0))
        constraint.append(likeButton.titleLabel!.rightAnchor.constraint(equalTo: likeButton.rightAnchor, constant: 0))
//        constraint.append(likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3))
        
        constraint.append(forwardButton.widthAnchor.constraint(equalToConstant: 45))
        constraint.append(forwardButton.heightAnchor.constraint(equalToConstant: 16))
        constraint.append(forwardButton.leftAnchor.constraint(equalTo: likeButton.rightAnchor, constant: 15))
        constraint.append(forwardButton.imageView!.topAnchor.constraint(equalTo: forwardButton.topAnchor, constant: 0))
        constraint.append(forwardButton.titleLabel!.rightAnchor.constraint(equalTo: forwardButton.rightAnchor, constant: 0))
        constraint.append(forwardButton.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -75))
//        constraint.append(forwardButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3))
        
        NSLayoutConstraint.activate(constraint)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
 
}
