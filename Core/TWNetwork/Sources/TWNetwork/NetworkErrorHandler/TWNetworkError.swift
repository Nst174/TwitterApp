//
//  TWNetworkError.swift
//  
//
//  Created by Kostya Pogonshchikov on 25.01.2021.
//

import Foundation

public enum TWNetworkError: LocalizedError {
    case decodingError
    case unknownError
}

public extension TWNetworkError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return NSLocalizedString("Decoding error occurs", comment: "")
        case .unknownError:
            return NSLocalizedString("Unknown Error", comment: "")
        }
    }
}
