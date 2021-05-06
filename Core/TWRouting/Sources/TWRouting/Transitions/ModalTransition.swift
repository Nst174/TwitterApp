//
//  ModalTransition.swift
//  Senat
//
//  Created by Dmitriy Zharov on 02.03.2020.
//  Copyright © 2020 Sberbank. All rights reserved.
//

import UIKit

/// Переход, осуществляющий модальный показ View
@objc
public class ModalTransition: NSObject {
    /// Объект, реализующий кастомную анимацию показа и закрытия экрана
    var animator: Animator?
    /// Переход анимированный или нет. По умолчанию - true
    var isAnimated: Bool = true
    
    var modalTransitionStyle: UIModalTransitionStyle
    var modalPresentationStyle: UIModalPresentationStyle
    
    /// Callback завершения показа/закрытия экрана
    var completionHandler: (() -> Void)?
    
    /// Исходный контекст, с какого экрана вызываем переход
	weak public var context: UIViewController?
    
    @objc
    public init(animator: Animator? = nil,
         isAnimated: Bool = true,
         modalTransitionStyle: UIModalTransitionStyle = .coverVertical,
         modalPresentationStyle: UIModalPresentationStyle = .fullScreen) {
        self.animator = animator
        self.isAnimated = isAnimated
        self.modalTransitionStyle = modalTransitionStyle
        self.modalPresentationStyle = modalPresentationStyle
    }
}

extension ModalTransition: Transition {
	public func open(_ viewController: UIViewController) {
        viewController.transitioningDelegate = self
        viewController.modalTransitionStyle = modalTransitionStyle
        viewController.modalPresentationStyle = modalPresentationStyle
        
        self.context?.present(viewController, animated: isAnimated, completion: completionHandler)
    }
    
	public func close(_ viewController: UIViewController) {
        viewController.dismiss(animated: isAnimated, completion: completionHandler)
    }
}

extension ModalTransition: UIViewControllerTransitioningDelegate {
	public func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        animator.isPresenting = true
        return animator
    }
    
	public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        animator.isPresenting = false
        return animator
    }
}
