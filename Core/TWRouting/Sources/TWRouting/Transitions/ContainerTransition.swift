//
//  ContainerTransition.swift
//  Senat
//
//  Created by Александр Волков on 22.09.2020.
//  Copyright © 2020 Sberbank. All rights reserved.
//

import UIKit

class ContainerTransition: NSObject, UIViewControllerTransitioningDelegate {
    var parentViewController: UIViewController?
    
    weak var context: UIViewController?
    
    @objc
    init(parentViewController: UIViewController?) {
        self.parentViewController = parentViewController
    }
}

extension ContainerTransition: Transition {
    func close(_ viewController: UIViewController) {
        parentViewController?.dismiss(animated: true, completion: nil)
    }
    
    func open(_ viewController: UIViewController) {
        guard let parentViewController = parentViewController else { return }
        
        parentViewController.show(viewController, sender: nil)
    }
}
