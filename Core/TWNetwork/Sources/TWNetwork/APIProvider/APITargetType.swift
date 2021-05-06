//
//  APITargetType.swift
//
//
//  Created by Kostya Pogonshchikov on 25.01.2021.
//

import Foundation
import Moya

/// Протокол для API для возможности расширения в будущем
public protocol APITargetType: TargetType {}

public extension APITargetType {
    var baseURL: URL {
        return URL(fileReferenceLiteralResourceName: "URL")
    }
}

public protocol JSONMockable {
    /// Имя файла с моками в бандле
    var fileName: String { get }
    
    /// Имя директорией с моками в бандле
    var directoryName: String { get }
    
    /// Экстеншен файла с моками, по-умолчанию .json
    var fileExtension: String { get }
}

public extension JSONMockable {
    var fileExtension: String {
        return "json"
    }
}
