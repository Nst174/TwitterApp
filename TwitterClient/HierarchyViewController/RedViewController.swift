//
//  RedViewController.swift
//  TwitterClient
//
//  Created by Marat Khuzhayarov on 02.03.2021.
//

import UIKit

class RedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.setTitle("Present", for: .normal)
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        view.addSubview(button)
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(self.presentationController)
        print(self.presentingViewController)
        print(self.presentedViewController)
        print(self.parent)
    }
    
    @objc
    func didTapButton(_ sender: UIButton) {
        let vc = GreenViewController()
        //navigationController?.pushViewController(vc, animated: true)
        present(vc, animated: true, completion: nil)
        
//        addChild(vc)
//        view.addSubview(vc.view)
//        vc.didMove(toParent: self)
    }

}
