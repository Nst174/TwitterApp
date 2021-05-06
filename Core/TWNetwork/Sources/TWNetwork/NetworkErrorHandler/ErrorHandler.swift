//
//  ErrorHandler.swift
//  
//
//  Created by Kostya Pogonshchikov on 25.01.2021.
//

import Moya

public protocol ErrorHandler {
    func retrieveCustomError(from errorSource: Result<Moya.Response, MoyaError>) -> Error?
}
