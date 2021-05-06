//
//  PushTransition.swift
//  Senat
//
//  Created by Dmitriy Zharov on 02.03.2020.
//  Copyright © 2020 Sberbank. All rights reserved.
//

import UIKit

/// Переход с добавлением экрана в навигационный стек
@objc
open class PushTransition: NSObject {
    /// Объект, реализующий кастомную анимацию показа и закрытия экрана
    open var animator: Animator?
    /// Переход анимированный или нет. По умолчанию - true
    open var isAnimated: Bool = true
    /// Callback завершения показа/закрытия экрана
    open var completionHandler: (() -> Void)?
    
    /// Исходный контекст, с какого экрана вызываем переход
    @objc open weak var context: UIViewController?
  
    @objc
    public init(animator: Animator? = nil, isAnimated: Bool = true) {
        self.animator = animator
        self.isAnimated = isAnimated
    }
}

extension PushTransition: Transition {
    public func open(_ viewController: UIViewController) {
        guard let navigationController = self.context as? UINavigationController ?? self.context?.navigationController else {
            return
        }
        navigationController.delegate = self
        navigationController.pushViewController(viewController, animated: isAnimated)
    }
    
    public func close(_ viewController: UIViewController) {
        guard let navigationController = self.context as? UINavigationController ?? self.context?.navigationController else {
            return
        }
        navigationController.popViewController(animated: isAnimated)
    }
}

extension PushTransition: UINavigationControllerDelegate {
    public func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool) {
        completionHandler?()
    }
    
    public func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        if operation == .push {
            animator.isPresenting = true
            return animator
        } else {
            animator.isPresenting = false
            return animator
        }
    }
}
