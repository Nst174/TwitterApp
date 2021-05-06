//
//  TwitterViewController.swift
//  TwitterClient
//
//  Created by OUT-Dobrolyubov1-NN on 18.03.2021.
//

import UIKit

class TwitterViewController: UIViewController {
    
    private let feeds = PostAPI.getPosts()

    let feedTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarSetup()
        feedTableViewSetup()
    }
    
    func feedTableViewSetup() {
        
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(feedTableView)
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        feedTableView.translatesAutoresizingMaskIntoConstraints = false

        
        feedTableView.register(HeaderTableViewCell.self, forCellReuseIdentifier: "HeaderCell")
        feedTableView.register(StoriesTableViewCell.self, forCellReuseIdentifier: "StoriesCell")
        feedTableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        
        
        feedTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        feedTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        feedTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        feedTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        view.addSubview(feedTableView)
    }
    
    func navBarSetup() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        navBar.backgroundColor = #colorLiteral(red: 0.09987620264, green: 0.7174673676, blue: 0.9175438285, alpha: 1)
        view.addSubview(navBar)
    }
}


extension TwitterViewController:  UITableViewDelegate, UITableViewDataSource {
    
//    Нажатие на ячейку
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Num: \(indexPath.row)")
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            switch (section) {
            case 0, 1:
                return 1
            default:
                return feeds.count
            }
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        switch (indexPath.section) {
        case 0:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as? HeaderTableViewCell
            headerCell?.selectionStyle = .none
            
            return headerCell!
        case 1:
            let storiesCell = tableView.dequeueReusableCell(withIdentifier: "StoriesCell", for: indexPath) as? StoriesTableViewCell
            
            return storiesCell!
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell

            cell.feed = feeds[indexPath.row]
            return cell

        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section) {
        case 0:
            return 50
        case 1:
            return 100
        default:
            return 100
        }
    }
}

