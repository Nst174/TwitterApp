//
//  NavBarCell.swift
//  TwitterClient
//
//  Created by 18574230 on 18.03.2021.
//

import UIKit

class NavBarTableViewCell: UITableViewCell {

    var titleDTO: TitleDTO? {
        didSet {
            menuButton.setImage(UIImage(named: titleDTO?.menuImageName ?? "camera.png"), for: .normal)
            twitterButton.setImage(UIImage(named: titleDTO?.twitterImage ?? "camera.png"), for: .normal)
            starButton.setImage(UIImage(named: titleDTO?.starImage ?? "camera.png"), for: .normal)
        }
    }
    
    private let menuButton : UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    private let twitterButton : UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    private let starButton : UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        menuButton.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
        contentView.addSubview(menuButton)
        contentView.addSubview(twitterButton)
        contentView.addSubview(starButton)
        addConstraints()
    }
    
    private func addConstraints() {
        var constraint = [NSLayoutConstraint]()
        
        constraint.append(menuButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0, constant: 20))
        constraint.append(menuButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0, constant: 20))
        constraint.append(menuButton.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 5))
        constraint.append(menuButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5))
        constraint.append(menuButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20))
        
        constraint.append(twitterButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0, constant: 20))
        constraint.append(twitterButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0, constant: 20))
        constraint.append(twitterButton.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 5))
        constraint.append(twitterButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5))
        constraint.append(twitterButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
        
        constraint.append(starButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0, constant: 20))
        constraint.append(starButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0, constant: 20))
        constraint.append(starButton.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 5))
        constraint.append(starButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5))
        constraint.append(starButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20))
        NSLayoutConstraint.activate(constraint)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func buttonClicked(sender: UIButton!) {
        print("Button Clicked")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
        }
    }
    
}
