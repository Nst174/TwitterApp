//
//  APIProviderFactory.swift
//  
//
//  Created by Kostya Pogonshchikov on 25.01.2021.
//

import Alamofire
import Moya
import Foundation
import UIKit

public class APIProviderFactory {
    private let session: Session
    private let apiURL: URL
    private let networkSettings: NetworkSettings
    
    private let errorHandler: ErrorHandler?
    
    public init(apiURL: URL,
                errorHandler: ErrorHandler?,
                networkSettings: NetworkSettings) {
        self.apiURL = apiURL
        self.errorHandler = errorHandler
        self.networkSettings = networkSettings
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = networkSettings.requestTimeoutInterval
        
        var trustEvaluator: ServerTrustEvaluating
        
        // Возможность отключать SSL Pinning через конфигурацию
        if networkSettings.shouldUseSSLPinning {
            trustEvaluator = PinnedCertificatesTrustEvaluator(acceptSelfSignedCertificates: true)
        } else {
            trustEvaluator = DisabledTrustEvaluator()
        }
        
        var evaluators: [String: ServerTrustEvaluating] = [:]
        
        if let trustedHost = apiURL.host {
            evaluators[trustedHost] = trustEvaluator
        }
        
        let serverTrustManager = ServerTrustManager(
            allHostsMustBeEvaluated: true,
            evaluators: evaluators
        )
        
        // Превент любого кэширования
        let cachedResponseHandler = ResponseCacher(behavior: .doNotCache)
    
        // Превент любого редиректа
        let redirectHandler = Redirector(behavior: .doNotFollow)

        let session = Session(
            configuration: sessionConfiguration,
            serverTrustManager: serverTrustManager,
            redirectHandler: redirectHandler,
            cachedResponseHandler: cachedResponseHandler
        )

        self.session = session
    }
    
    /// Создает сконфигурированный провайдер для определенного API,
    /// с настроенной network сессией, плагинами и базовыми настройками для каждого запроса к API
    /// - Parameter apiURL: Использовать ли {baseURL}/api
    /// - Returns: Провайдер API
    
    public func makeProvider<API: APITargetType>() -> APIProvider<API> {
        // swiftlint:disable unowned_variable_capture
        let endpointClosure = { [unowned self] (target: API) -> Endpoint in
            let urlString = self.apiURL.appendingPathComponent(target.path).absoluteString

            return Endpoint(
                url: urlString,
                sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            ).adding(newHTTPHeaderFields: self.additionalHTTPHeaders)
        }
        // swiftlint:enable unowned_variable_capture
        
        let moyaProvider = MoyaProvider<API>(
            endpointClosure: endpointClosure,
            session: self.session,
            plugins: self.makePlugins()
        )
        
        let provider = APIProvider(
            moyaProvider: moyaProvider,
            networkErrorHandler: errorHandler
        )

        return provider
    }
}

// MARK: - Additional Setup
extension APIProviderFactory {
    private var additionalHTTPHeaders: [String: String] {
        var headers: [String: String] = [:]
        
        headers["Content-type"] = "application/json"
        
        if let deviceUUIDString = UIDevice.current.identifierForVendor?.uuidString {
            headers["UUID"] = deviceUUIDString
        }
        
        if let appVersionString = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            headers["App-Version"] = appVersionString
        }

        return headers
    }
}

// MARK: Private
extension APIProviderFactory {
    private func makePlugins() -> [PluginType] {
        let networkLoggingPlugin = CGDNetworkLoggingPlugin()
        return [networkLoggingPlugin]
    }
}
