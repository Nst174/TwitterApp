//
//  HeaderTableViewCell.swift
//  TwitterClient
//
//  Created by OUT-Dobrolyubov1-NN on 19.03.2021.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    let twitterImage: UIImageView = {
       let image = UIImageView(image: UIImage(named: "twitter_circle"))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 35
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(twitterImage)
        backgroundColor = #colorLiteral(red: 0.116285719, green: 0.7173357606, blue: 0.9217116833, alpha: 1)
        twitterImage.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        twitterImage.centerXAnchor.constraint(equalTo:self.contentView.centerXAnchor).isActive = true
        twitterImage.widthAnchor.constraint(equalToConstant:50).isActive = true
        twitterImage.heightAnchor.constraint(equalToConstant:50).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
