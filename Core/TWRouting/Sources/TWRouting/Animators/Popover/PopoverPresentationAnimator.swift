//
//  PopoverPresentationAnimator.swift
//  Senat
//
//  Created by OUT-Pavlova-AV on 19/03/2020.
//  Copyright © 2020 Sberbank. All rights reserved.
//

import UIKit

class PopoverPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toViewController = transitionContext.viewController(forKey: .to) else {
                transitionContext.completeTransition(false)
                return
        }
        containerView.frame = toViewController.view.frame
        containerView.clipsToBounds = true
        toViewController.view.frame = toViewController.view.bounds
        toViewController.view.layer.shadowColor = UIColor.black.cgColor
        toViewController.view.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        toViewController.view.layer.shadowOpacity = 0.3
        toViewController.view.layer.cornerRadius = 12.0
        toViewController.view.clipsToBounds = true
        
        containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
                toViewController.view.alpha = 1
            }, completion: { _ in transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        )
    }
}
