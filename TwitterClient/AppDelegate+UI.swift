//
//  AppDelegate+UI.swift
//  TwitterClient
//
//  Created by Marat Khuzhayarov on 02.03.2021.
//

import UIKit

extension AppDelegate {
    
    func showUI() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = TweetViewController()
//        let vc = AuthViewController(twitterAuthService: TwitterAuthService(securityService: SecurityService()))
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
}

//extension AppDelegate {
//    
//    func showUI() {
//        window = UIWindow(frame: UIScreen.main.bounds)
//        let vc = TweetViewController()
////        let vc = AuthViewController(twitterAuthService: TwitterAuthService(securityService: SecurityService()))
//        let navVc = UINavigationController(rootViewController: vc)
//        window?.rootViewController = navVc
//        window?.makeKeyAndVisible()
//    }
//    
//}
//
//// navigationController push viewcontroller
