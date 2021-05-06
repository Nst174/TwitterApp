//
//  CustomSafariWebViewController.swift
//  TwitterClient
//
//  Created by Marat Khuzhayarov on 25.02.2021.
//

import Foundation
import SafariServices

class CustomSafariWebViewController: UIViewController {
    
    var url: URL? {
        didSet {
            configure()
        }
    }
    
    private var safariViewController: SFSafariViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        if let safariViewController = safariViewController {
            safariViewController.willMove(toParent: nil)
            safariViewController.view.removeFromSuperview()
            safariViewController.removeFromParent()
            self.safariViewController = nil
        }
        guard let url = url else {
            return
        }
        let newSafariViewController = SFSafariViewController(url: url)
        addChild(newSafariViewController)
        newSafariViewController.view.frame = view.frame
        view.addSubview(newSafariViewController.view)
        newSafariViewController.didMove(toParent: self)
        self.safariViewController = newSafariViewController
    }
}
