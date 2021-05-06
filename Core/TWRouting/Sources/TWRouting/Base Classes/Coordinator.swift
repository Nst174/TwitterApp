//
//  Coordinator.swift
//  Senat
//
//  Created by Evgeny Shishko on 22.04.2020.
//  Copyright © 2020 Sberbank. All rights reserved.
//

import Foundation

public protocol CoordinatorProtocol: AnyObject {
    func start()
}

open class Coordinator: NSObject, CoordinatorProtocol {
    open var children: [Coordinator] = []
    
    open func start() {
    }
    
    /// Добавляет только уникальные (по ссылке) координаторы
    open func addChild(_ coordinator: Coordinator) {
        for child in children where child === coordinator { return }
        children.append(coordinator)
    }
    
    open func removeChild(_ coordinator: Coordinator?) {
        guard children.isEmpty == false, let coordinator = coordinator else { return }
        
        for (index, element) in children.enumerated() where element === coordinator {
            children.remove(at: index)
            return
        }
    }
}
