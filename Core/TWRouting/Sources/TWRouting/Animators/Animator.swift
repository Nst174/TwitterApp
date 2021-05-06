//
//  Animator.swift
//  Senat
//
//  Created by Dmitriy Zharov on 02.03.2020.
//  Copyright © 2020 Sberbank. All rights reserved.
//

import UIKit

/// Объект, реализующий кастомную анимацию показа и закрытия экрана
@objc
public protocol Animator: UIViewControllerAnimatedTransitioning {
  @objc var isPresenting: Bool { get set } // Показан ли сейчас экран
}
