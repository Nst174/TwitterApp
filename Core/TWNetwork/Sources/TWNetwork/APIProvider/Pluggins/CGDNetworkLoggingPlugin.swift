//
//  File.swift
//  
//
//  Created by Kostya Pogonshchikov on 25.01.2021.
//

import Foundation
import Moya

public class CGDNetworkLoggingPlugin: PluginType {
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let moyaResponse):
            let messages = collectSuccessResponseMessages(from: moyaResponse)
            logMessages(messages)
            
        case .failure(let error):
            let errorMessages = collectErrorMessage(from: error)
            logMessages(errorMessages)
        }
    }
}

extension CGDNetworkLoggingPlugin {
    private func logMessages(_ messages: [String]) {
        for item in messages {
            print(item, separator: ",", terminator: "\n")
        }
    }
    
    private func collectSuccessResponseMessages(from response: Response) -> [String] {
        return collectResponseMessages(from: response, isFromError: false)
    }
    
    private func collectResponseMessages(from moyaResponse: Response, isFromError: Bool) -> [String] {
        var responseMessages: [String] = []
        
        if let urlString = moyaResponse.response?.url?.absoluteString {
            var isSuccessfulStatusCode: Bool = true
            do {
                _ = try moyaResponse.filterSuccessfulStatusAndRedirectCodes()
            } catch {
                isSuccessfulStatusCode = false
            }
            
            if isFromError || !isSuccessfulStatusCode {
                responseMessages.append("❌ URL: \(urlString)")
            } else {
                responseMessages.append("✅ URL: \(urlString)")
            }
        }
        
        if let statusCode = moyaResponse.response?.statusCode {
            responseMessages.append("statusCode: \(String(statusCode))")
        }
        
        let jsonString = formatJSONResponse(moyaResponse.data)
        responseMessages.append("JSON: \(jsonString)")
        
        return responseMessages
    }
    
    private func collectErrorMessage(from error: MoyaError) -> [String] {
        var errorMessages: [String] = []
        
        if let response = error.response {
            errorMessages.append(contentsOf: collectResponseMessages(from: response, isFromError: true))
        }
        
        if let errorDescription = error.errorUserInfo[NSLocalizedDescriptionKey] as? String {
            errorMessages.append("errorDescription: \(errorDescription)")
        }
        
        if let underlyingError = error.errorUserInfo[NSUnderlyingErrorKey] as? String {
            errorMessages.append("underlyingError: \(underlyingError)")
        }
        
        error.errorUserInfo.keys.forEach { errorMessages.append("\($0): \(String(describing: error.errorUserInfo[$0]))") }
        
        return errorMessages
    }
    
    private func formatJSONResponse(_ data: Data) -> String {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
        } catch {
            return String(data: data, encoding: .utf8) ?? ""
        }
    }
}
