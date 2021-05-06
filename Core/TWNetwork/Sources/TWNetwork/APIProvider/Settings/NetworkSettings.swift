//
//  NetworkSettings.swift
//  
//
//  Created by Kostya Pogonshchikov on 25.01.2021.
//

import Foundation

public struct NetworkSettings {
    /// Использовать ли SSL Pinning
    public let shouldUseSSLPinning: Bool
    
    /// Timeout респонса для сетевых запросов
    public let requestTimeoutInterval: Double
    
    public init(shouldUseSSLPinning: Bool,
                requestTimeoutInterval: Double) {
        self.shouldUseSSLPinning = shouldUseSSLPinning
        self.requestTimeoutInterval = requestTimeoutInterval
    }
    
    public init() {
        self.shouldUseSSLPinning = Self.shouldUseSSLPinning
        self.requestTimeoutInterval = Self.requestTimeoutInterval
    }
}

extension NetworkSettings {
    private static let shouldUseSSLPinning = false
    private static let requestTimeoutInterval: Double = 30.0
}
