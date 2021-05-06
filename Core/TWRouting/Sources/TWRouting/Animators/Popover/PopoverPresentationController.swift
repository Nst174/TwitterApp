//
//  PopoverPresentationController.swift
//  Senat
//
//  Created by OUT-Pavlova-AV on 19/03/2020.
//  Copyright © 2020 Sberbank. All rights reserved.
//

import UIKit

class PopoverPresentationController: UIPresentationController {
    var popoverSize = CGSize(width: 0, height: 0)
    
    override var frameOfPresentedViewInContainerView: CGRect {
        if self.presentedView == nil {
            return super.frameOfPresentedViewInContainerView
        }
        let height = self.containerView!.bounds.size.height
        return CGRect(x: 16, y: height * 0.2, width: popoverSize.width, height: popoverSize.height)
    }
    
    override func containerViewWillLayoutSubviews() {
        self.presentedView!.frame = self.frameOfPresentedViewInContainerView
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        self.containerView!.backgroundColor = UIColor(red: 4 / 255, green: 4 / 255, blue: 4 / 255, alpha: 0.4)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        tapRecognizer.delegate = self
        self.containerView?.addGestureRecognizer(tapRecognizer)
        self.containerView?.alpha = 0
        self.presentedViewController.transitionCoordinator?.animate(
            alongsideTransition: { (_: UIViewControllerTransitionCoordinatorContext) in self.containerView!.alpha = 1 },
            completion: nil
        )
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        self.presentedViewController.transitionCoordinator?.animate(
            alongsideTransition: { (_: UIViewControllerTransitionCoordinatorContext) in
                self.containerView!.alpha = 1
            }, completion: nil
        )
    }
    
    @objc
    func backgroundTapped(sender: UIGestureRecognizer) {
        dismissAnimated()
    }
    
    func dismissAnimated() {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}

extension PopoverPresentationController: UIGestureRecognizerDelegate {
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldReceive touch: UITouch) -> Bool {
        return gestureRecognizer.view == touch.view
    }
}
