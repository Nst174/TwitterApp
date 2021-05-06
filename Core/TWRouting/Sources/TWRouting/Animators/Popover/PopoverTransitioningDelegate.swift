//
//  PopoverTransitioningDelegate.swift
//  Senat
//
//  Created by OUT-Pavlova-AV on 19/03/2020.
//  Copyright © 2020 Sberbank. All rights reserved.
//

import UIKit

class PopoverTransitioningDelegate: NSObject {
    var popoverSize: CGSize
    
    init(size: CGSize) {
        popoverSize = size
    }
}

extension PopoverTransitioningDelegate: UIViewControllerTransitioningDelegate {
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        let presentationController = PopoverPresentationController(presentedViewController: presented, presenting: presenting)
        presentationController.popoverSize = popoverSize
        return presentationController
    }
    
    func animationControllerForPresentedController(
        presented: UIViewController,
        presentingController presenting: UIViewController,
        sourceController source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        let animationController = PopoverPresentationAnimator()
        return animationController
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = PopoverDismissAnimator()
        return animationController
    }
}
