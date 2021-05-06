//
//  TwittViewController.swift
//  TwitterClient
//
//  Created by 18574230 on 12.03.2021.
//

import UIKit

class TweetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    let menuVC = MenuViewController()
    
    let tweetCellId = "tweetcellId"
    let titleCellId = "titleCellId"
    let storiesCellId = "storiesCellId"
    
    var rowItems: [[RowItem]] = []
    
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    
    //loadView
    override func viewDidLoad() {
        super.loadView()
        tableView.dataSource = self
        tableView.delegate = self
        createTweetsArray()
        view.backgroundColor = .white
        view.layoutMargins = UIEdgeInsets.zero
        view.addSubview(tableView)
        addChildViewController()
        setupTableView()
        tableView.reloadData()
    }

    private func addChildViewController() {
        addChild(menuVC)
//        view.addSubview(menuVC.view)
//        menuVC.didMove(toParent: self)
    }
    
    func setupTableView() {
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: tweetCellId)
        tableView.register(NavBarTableViewCell.self, forCellReuseIdentifier: titleCellId)
        tableView.register(StoriesTableViewCell.self, forCellReuseIdentifier: storiesCellId)
        tableView.separatorInset = UIEdgeInsets.zero
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createTweetsArray() {
        rowItems.append([.title(TitleDTO(menuImageName: "menu.png", twitterImage: "twitter.png", starImage: "star.png"))])
        rowItems.append([.stories([
                                Story(profileImageName: "Marat.jpg", profileName: "@marat_huzh"),
                                Story(profileImageName: "Nikita.jpg", profileName: "@nikita_dobr"),
                                Story(profileImageName: "Eduard.jpg", profileName: "@ed__ist")])])
        rowItems.append([.tweets(Tweet(userRealName: "Марат", userName: "@marat_huzh", userImage: UIImage(named: "Marat.jpg")!, userMessage: "Короткий твит на одну строку", messageImageName: nil))])
        rowItems.append([.tweets(Tweet(userRealName: "Никита", userName: "@nikita_dobr", userImage: UIImage(named: "Nikita.jpg")!, userMessage: "Средний твит располагающийся на нескольких строках", messageImageName: nil))])
        rowItems.append([.tweets(Tweet(userRealName: "Эдуард", userName: "@ed__ist", userImage: UIImage(named: "Eduard.jpg")!, userMessage: "Очень большой твит, который должен занимать много строк и демонстрировать то, что размер ячейки является динамическим", messageImageName: nil))])
        rowItems.append([.tweets(Tweet(userRealName: "Dodo", userName: "@dodo", userImage: UIImage(named: "dodo.jpg")!, userMessage: "Одна пицца хорошо, а две ещё лучше! 🍕🍕Выберите две любые пиццы на dodopizza.ru, в мобильном приложении (vk.cc/99vs23) или в ресторане. Введите или назовите промокод 4209 и получите скидку 50% на вторую пиццу, меньшую по цене.", messageImageName: "pizza.jpg"))])
        rowItems.append([.tweets(Tweet(userRealName: "СТС", userName: "@ctc", userImage: UIImage(named: "sts.jpg")!, userMessage: "Добро пожаловать в мою память 😂 Смотри шоу «Миша портит всё» сегодня в 14:30 на СТС!", messageImageName: "sts_kino.jpg"))])
        rowItems.append([.tweets(Tweet(userRealName: "Суши Вок", userName: "@susi_wok", userImage: UIImage(named: "susi.jpg")!, userMessage: "Найти время для отдыха можно даже в водовороте повседневных дел 😌 Заказывайте ужин в Суши Wok, чтобы передохнуть от этой сложной среды и порадовать себя вкусненьким!", messageImageName: "susi_foto.jpg"))])
    }
}

extension TweetViewController {

    func numberOfSections(in tableView: UITableView) -> Int {
        return rowItems.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = rowItems[indexPath.section][indexPath.row]
        switch item {
        case .title(let titleDTO):
            let cell = tableView.dequeueReusableCell(withIdentifier: titleCellId, for: indexPath) as! NavBarTableViewCell
            cell.selectionStyle = .none
            cell.titleDTO = titleDTO
            return cell
        case .tweets(let tweetDTO):
            let cell = tableView.dequeueReusableCell(withIdentifier: tweetCellId, for: indexPath) as! TweetTableViewCell
            cell.selectionStyle = .none
            let currentLastItem = tweetDTO
            cell.tweetDTO = currentLastItem
            return cell
        case .stories(let storiesDTO):
            let cell = tableView.dequeueReusableCell(withIdentifier: storiesCellId, for: indexPath) as! StoriesTableViewCell
            cell.selectionStyle = .none
            cell.storyDTO = storiesDTO
            return cell
        }
    }
    
}
