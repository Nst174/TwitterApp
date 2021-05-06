//
//  Transition.swift
//  Senat
//
//  Created by Dmitriy Zharov on 02.03.2020.
//  Copyright © 2020 Sberbank. All rights reserved.
//

import UIKit

/// Протокол, определяющий контракт перехода
public protocol Transition {
    /// Исходный контекст, с какого экрана вызываем переход
    var context: UIViewController? { get set }
    
    /// Выполнения перехода с context на viewController
    /// - Parameter viewController: viewController модуля, на которых хотим осуществить переход
    func open(_ viewController: UIViewController)
    /// Выполнение обратного перехода (закрытия) с viewController
    /// - Parameter viewController: viewController модуля, с которого делаем обратный переход
    func close(_ viewController: UIViewController)
}
