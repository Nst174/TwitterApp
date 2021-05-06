//
//  APIProvider.swift
//  
//
//  Created by Kostya Pogonshchikov on 25.01.2021.
//

import Foundation
import Moya

public typealias APIProviderCompletion = (_ result: Result<Moya.Response, Error>) -> Void
public typealias APIProviderDecodedResponseCompletion<T: Decodable> = (_ result: Result<T, Error>) -> Void

public class APIProvider<API: APITargetType> {
    private let moyaProvider: MoyaProvider<API>
    private let networkErrorHandler: ErrorHandler?

    public init(
        moyaProvider: MoyaProvider<API>,
        networkErrorHandler: ErrorHandler?) {
        self.moyaProvider = moyaProvider
        self.networkErrorHandler = networkErrorHandler
    }

    @discardableResult
    public func request(_ target: API,
                        callbackQueue: DispatchQueue? = .none,
                        progress: ProgressBlock? = .none,
                        completion: @escaping APIProviderCompletion) -> Cancellable {
        moyaProvider.request(
            target,
            callbackQueue: callbackQueue,
            progress: progress) { [weak self] result in
            guard let self = self else {
                return
            }
            
            if let error = self.networkErrorHandler?.retrieveCustomError(from: result) {
                completion(.failure(error))
                return
            }

            switch result {
            case .success(let response):
                completion(.success(response))

            case .failure(let moyaError):
                let error = moyaError as Error
                completion(.failure(error))
            }
        }
    }
    
    @discardableResult
    public func requestWithDecodable<T: Decodable>(_ target: API,
                                                   callbackQueue: DispatchQueue? = .none,
                                                   progress: ProgressBlock? = .none,
                                                   completion: @escaping APIProviderDecodedResponseCompletion<T>) -> Cancellable {
        moyaProvider.request(
            target,
            callbackQueue: callbackQueue,
            progress: progress) { [weak self] result in
            guard let self = self else {
                return
            }
            
            if let error = self.networkErrorHandler?.retrieveCustomError(from: result) {
                completion(.failure(error))
                return
            }
            
            switch result {
            case .success(let response):
                do {
                    let dto = try response.map(T.self)
                    completion(.success(dto))
                } catch {
                    #if DEBUG
                    print(error)
                    #endif
                    completion(.failure(TWNetworkError.decodingError))
                }
                
            case .failure(let moyaError):
                let error = moyaError as Error
                completion(.failure(error))
            }
        }
    }
}
