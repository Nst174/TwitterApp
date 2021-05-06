//
//  StoriesTableViewCell.swift
//  TwitterClient
//
//  Created by OUT-Dobrolyubov1-NN on 19.03.2021.
//

import UIKit


class StoriesTableViewCell: UITableViewCell {

    
    private let stories = StoriesAPI.getStories()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        let storiesCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 400, height: 100), collectionViewLayout: layout)
        storiesCollectionView.backgroundColor = UIColor.white
        storiesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        storiesCollectionView.showsHorizontalScrollIndicator = false
        storiesCollectionView.showsVerticalScrollIndicator = false
        self.contentView.addSubview(storiesCollectionView)
        
        storiesCollectionView.register(StoriesCollectionViewCell.self, forCellWithReuseIdentifier: "StorieCell")
        storiesCollectionView.dataSource = self
        storiesCollectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension StoriesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StorieCell", for: indexPath) as? StoriesCollectionViewCell
        cell?.storie = stories[indexPath.row]
        return cell!
    }
    
    
}



