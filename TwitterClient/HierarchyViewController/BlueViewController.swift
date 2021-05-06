//
//  BlueViewController.swift
//  TwitterClient
//
//  Created by Marat Khuzhayarov on 02.03.2021.
//

import UIKit

class BlueViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(self.presentationController)
        print(self.presentingViewController)
        print(self.presentedViewController)
        print(self.parent)
    }

}
