//
//  TWErrorHandler.swift
//  
//
//  Created by 08428813 on 03.02.2021.
//

import Foundation
import Moya

public class TWErrorHandler: ErrorHandler {
    public init() {}
    public func retrieveCustomError(from errorSource: Result<Response, MoyaError>) -> Error? {
        var networkResponse: Moya.Response?
        switch errorSource {
        case .success(let response):
            networkResponse = response

        case .failure(let error):
            if let response = error.response {
                networkResponse = response
            } else {
                return TWNetworkError.unknownError
            }
        }
        
        guard let response = networkResponse else { return nil }
        guard (200...299).contains(response.statusCode) else {
            return MoyaError.statusCode(response)
        }
        
        // TODO: Custom Errors mapping
        
        return nil
    }
}
