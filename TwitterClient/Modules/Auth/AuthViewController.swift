//
//  AuthViewController.swift
//  TwitterClient
//
//  Created by Marat Khuzhayarov on 26.02.2021.
//

import UIKit


class AuthViewController: UIViewController {
    
    private let twitterAuthService: TwitterAuthService
    private let safariVc = CustomSafariWebViewController()
    
    // MARK: Initialization
    required init(twitterAuthService: TwitterAuthService) {
        self.twitterAuthService = twitterAuthService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let presentButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.setTitle("Present", for: .normal)
        button.addTarget(self, action: #selector(authButtonPressed(_:)), for: .touchUpInside)
        button.backgroundColor = .red
        return button
    }()
    
    private let twitterButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        button.setTitle("Twitter", for: .normal)
        button.addTarget(self, action: #selector(twitterButtonTapped(_:)), for: .touchUpInside)
        button.backgroundColor = .red
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        scrollView.addSubview(presentButton)
        scrollView.addSubview(twitterButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.self.frame.size.width/3
        
        presentButton.frame = CGRect(x: (scrollView.self.frame.size.width-size)/2,
                                   y: 200,
                                   width: size,
                                   height: 52)
        twitterButton.frame = CGRect(x: (scrollView.self.frame.size.width-size)/2, y: 300, width: size, height: 52)

    }
    
    @objc private func authButtonPressed(_ sender: UIButton) {
        twitterAuthService.authorize {[weak self] (url) in
            guard let self = self else {
                return
            }
            self.safariVc.url = url
            self.present(self.safariVc, animated: true, completion: nil)
        } completion: {[weak self] (result) in
            switch result {
            case .success(_): print("success")
            case .failure(let error): print(error.localizedDescription)
            }
            guard let self = self else {
                return
            }
            self.safariVc.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func twitterButtonTapped(_ sender: UIButton) {
        let vc = TweetViewController()
            
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

}
