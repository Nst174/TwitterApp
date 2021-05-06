//
//  ParametrsStringHelper.swift
//  TwitterClient
//
//  Created by Marat Khuzhayarov on 25.02.2021.
//

import Foundation
import CommonCrypto

func authorizationHeader(params: [String: Any]) -> String {
    var parts: [String] = []
    for param in params {
        let key = param.key.urlEncoded
        let val = "\(param.value)".urlEncoded
        parts.append("\(key)=\"\(val)\"")
    }
    return "OAuth " + parts.sorted().joined(separator: ", ")
}

func signatureKey(_ consumerSecret: String,_ oauthTokenSecret: String?) -> String {
  
    guard let oauthSecret = oauthTokenSecret?.urlEncoded
          else { return consumerSecret.urlEncoded+"&" }
  
    return consumerSecret.urlEncoded+"&"+oauthSecret
  
}

func signatureParameterString(params: [String: Any]) -> String {
    var result: [String] = []
    for param in params {
        let key = param.key.urlEncoded
        let val = "\(param.value)".urlEncoded
        result.append("\(key)=\(val)")
    }
    return result.sorted().joined(separator: "&")
}

func signatureBaseString(_ httpMethod: String = "POST",_ url: String,
                         _ params: [String:Any]) -> String {
  
    let parameterString = signatureParameterString(params: params)
    return httpMethod + "&" + url.urlEncoded + "&" + parameterString.urlEncoded
}

func hmac_sha1(signingKey: String, signatureBase: String) -> String {
    // HMAC-SHA1 hashing algorithm returned as a base64 encoded string
    var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
    CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), signingKey, signingKey.count, signatureBase, signatureBase.count, &digest)
    let data = Data(digest)
    return data.base64EncodedString()
}

func oauthSignature(httpMethod: String = "POST", url: String,
                    params: [String: Any], consumerSecret: String,
                    oauthTokenSecret: String? = nil) -> String {
  
    let signingKey = signatureKey(consumerSecret, oauthTokenSecret)
    let signatureBase = signatureBaseString(httpMethod, url, params)
    return hmac_sha1(signingKey: signingKey, signatureBase: signatureBase)
}
