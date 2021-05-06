//
//  PopoverDismissAnimator.swift
//  Senat
//
//  Created by OUT-Pavlova-AV on 19/03/2020.
//  Copyright © 2020 Sberbank. All rights reserved.
//

import UIKit

class PopoverDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //let containerView = transitionContext.containerView
        guard let fromViewController = transitionContext.viewController(forKey: .from) else {
                transitionContext.completeTransition(false)
                return
        }
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
                fromViewController.view.alpha = 1
            }, completion: { _ in transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        )
    }
}
