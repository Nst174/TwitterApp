//
//  Router.swift
//  Senat
//
//  Created by Dmitriy Zharov on 02.03.2020.
//  Copyright © 2020 Sberbank. All rights reserved.
//

import UIKit

@objc
public protocol RouterProtocol {
    /// Контекст роутера для выполнения показов
    weak var context: UIViewController? { get set }
    
    /// Открытие начального экрана модуля
	func open()

    func open(viewController: UIViewController)
    
    /// Закрытие модуля
    func close()
}

open class Router: NSObject, RouterProtocol {
    open weak var context: UIViewController?
    open var transition: Transition?
    
	open func open() {}

    open func open(viewController: UIViewController) {
        assertionFailure("You should implement this method in subclass to execute transition opening")
    }
    
    open func close() {
        guard let transition = transition else {
          assertionFailure("You should specify an open transition in order to close a module.")
          return
        }
        guard let context = context else {
          assertionFailure("Nothing to close.")
          return
        }
        transition.close(context)
    }
}

extension Router {
    open func findChildVC<T: UIViewController>(
        byType: T.Type,
        in viewController: UIViewController? = nil
    ) -> UIViewController? {
        let parentViewController = viewController ?? context
        return parentViewController?.children.first { $0 is T }
    }
}
