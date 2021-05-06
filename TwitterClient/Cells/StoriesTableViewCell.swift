//
//  StoriesCell.swift
//  TwitterClient
//
//  Created by 18574230 on 18.03.2021.
//

import UIKit

class StoriesTableViewCell: UITableViewCell {
    
    var storyDTO: [Story]?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let storiesCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            layout.minimumInteritemSpacing = 0
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.translatesAutoresizingMaskIntoConstraints = false
            cv.backgroundColor = .white
            cv.showsHorizontalScrollIndicator = false
            cv.delegate = self
            cv.dataSource = self
            cv.register(StoryCollectionViewCell.self, forCellWithReuseIdentifier: "storyCollCellId")
            return cv
        }()
        contentView.addSubview(storiesCollectionView)
        NSLayoutConstraint.activate([
            storiesCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            storiesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            storiesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            storiesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
                                     
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StoriesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "storyCollCellId", for: indexPath) as! StoryCollectionViewCell
        cell.backgroundColor = .white
        cell.profileImage.image = UIImage(named: storyDTO?[indexPath.row].profileImageName ?? "camera.png")
        cell.profileImage.layer.borderColor = UIColor.black.cgColor
        cell.profileImage.layer.borderWidth = 1.0
        cell.profileName.text = storyDTO?[indexPath.row].profileName
        return cell
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 415, height: 75)
//    }
}
