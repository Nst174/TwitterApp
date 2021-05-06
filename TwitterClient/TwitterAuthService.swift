//
//  TwitterServicee.swift
//  TwitterClient
//
//  Created by Marat Khuzhayarov on 25.02.2021.
//

import Foundation

let TWITTER_CONSUMER_KEY = "izS89GX9MJuLU41Up8OQfJ8YF"
let TWITTER_CONSUMER_SECRET = "XeaPbjiTBfupprUEkZmOfwXFyAWJ7AYMEjQ1zF3n5QO6llTCU4"
let TWITTER_URL_SCHEME = "twittersdkmrt"


extension Notification.Name {
    fileprivate static let twitterCallback = Notification.Name(rawValue: "Twitter.CallbackNotification.Name")
}

class TwitterAuthService {
    
    enum Error: LocalizedError {
        case invalidURL
        case requestAccessTokenNetwork(String)
        case requestAccessTokenInvalidData
        case requestOAuthTokenNetwork(String)
        case requestOAuthTokenInvalidData
        case invalidURLParametrs
        
        var errorDescription: String? {
            switch self {
            case .invalidURL: return "Invalid URL"
            case .requestAccessTokenNetwork(let errorString): return "requestAccessToken: " + errorString
            case .requestAccessTokenInvalidData: return "requestAccessToken: Invalid data"
            case .requestOAuthTokenNetwork(let errorString): return "requestOAuthToken: " + errorString
            case .requestOAuthTokenInvalidData: return "requestOAuthToken: Invalid data"
            case .invalidURLParametrs: return "Invalid URL-parametrs"
            }
        }
    }
    
    struct RequestOAuthTokenInput {
        let consumerKey: String
        let consumerSecret: String
        let callbackScheme: String
    }
    
    struct RequestOAuthTokenResponse {
        let oauthToken: String
        let oauthTokenSecret: String
        let oauthCallbackConfirmed: String
    }
    
    struct RequestAccessTokenInput {
        let consumerKey: String
        let consumerSecret: String
        let requestToken: String // = RequestOAuthTokenResponse.oauthToken
        let requestTokenSecret: String // = RequestOAuthTokenResponse.oauthTokenSecret
        let oauthVerifier: String
    }
    struct RequestAccessTokenResponse {
        let accessToken: String
        let accessTokenSecret: String
        let userId: String
        let screenName: String
    }
    
    let securityService: SecurityServiceProtocol
    
    required init(securityService: SecurityServiceProtocol) {
        self.securityService = securityService
    }
    
    private var callbackObserver: Any? {
        willSet {
            guard let token = callbackObserver else { return }
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    private func requestOAuthToken(args: RequestOAuthTokenInput,_ complete: @escaping (Result<RequestOAuthTokenResponse, Error>) -> Void) {
      
        let request = (url: "https://api.twitter.com/oauth/request_token", httpMethod: "POST")
        let callback = args.callbackScheme + "://success"
      
        var params: [String: Any] = [
            "oauth_callback" : callback,
            "oauth_consumer_key" : args.consumerKey,
            "oauth_nonce" : UUID().uuidString, // nonce can be any 32-bit string made up of random ASCII values
            "oauth_signature_method" : "HMAC-SHA1",
            "oauth_timestamp" : String(Int(Date().timeIntervalSince1970)),
            "oauth_version" : "1.0"
        ]
        // Build the OAuth Signature from Parameters
        params["oauth_signature"] = oauthSignature(httpMethod: request.httpMethod, url: request.url,
                                                 params: params, consumerSecret: args.consumerSecret)
      
        // Once OAuth Signature is included in our parameters, build the authorization header
        let authHeader = authorizationHeader(params: params)
      
        guard let url = URL(string: request.url) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod
        urlRequest.setValue(authHeader, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                complete(.failure(.requestOAuthTokenNetwork(error!.localizedDescription)))
                return
            }
            guard let data = data,
                  let dataString = String(data: data, encoding: .utf8) else {
                complete(.failure(.requestOAuthTokenInvalidData))
                return
            }
            // dataString should return: oauth_token=XXXX&oauth_token_secret=YYYY&oauth_callback_confirmed=true
            let attributes = dataString.urlQueryStringParameters
            let result = RequestOAuthTokenResponse(oauthToken: attributes["oauth_token"] ?? "",
                                                   oauthTokenSecret: attributes["oauth_token_secret"] ?? "",
                                                   oauthCallbackConfirmed: attributes["oauth_callback_confirmed"] ?? "")
            complete(.success(result))
        }
        task.resume()
    }
    
    private func requestAccessToken(args: RequestAccessTokenInput,
                            _ complete: @escaping (Result<RequestAccessTokenResponse, Error>) -> Void) {
      
        let request = (url: "https://api.twitter.com/oauth/access_token", httpMethod: "POST")
      
        var params: [String: Any] = [
            "oauth_token" : args.requestToken,
            "oauth_verifier" : args.oauthVerifier,
            "oauth_consumer_key" : args.consumerKey,
            "oauth_nonce" : UUID().uuidString, // nonce can be any 32-bit string made up of random ASCII values
            "oauth_signature_method" : "HMAC-SHA1",
            "oauth_timestamp" : String(Int(Date().timeIntervalSince1970)),
            "oauth_version" : "1.0"
        ]
      
        // Build the OAuth Signature from Parameters
        params["oauth_signature"] = oauthSignature(httpMethod: request.httpMethod, url: request.url,
                                                 params: params, consumerSecret: args.consumerSecret,
                                                 oauthTokenSecret: args.requestTokenSecret)
      
        // Once OAuth Signature is included in our parameters, build the authorization header
        let authHeader = authorizationHeader(params: params)
      
        guard let url = URL(string: request.url) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod
        urlRequest.setValue(authHeader, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                complete(.failure(.requestAccessTokenNetwork(error!.localizedDescription)))
                return
            }
            guard let data = data,
                  let dataString = String(data: data, encoding: .utf8) else {
                complete(.failure(.requestAccessTokenInvalidData))
                return
            }
            let attributes = dataString.urlQueryStringParameters
            let result = RequestAccessTokenResponse(accessToken: attributes["oauth_token"] ?? "",
                                                accessTokenSecret: attributes["oauth_token_secret"] ?? "",
                                                userId: attributes["user_id"] ?? "",
                                                screenName: attributes["screen_name"] ?? "")
            complete(.success(result))
        }
        task.resume()
    }
    
    private func addObserverForTwitterCallback(oAuthTokenResponse: RequestOAuthTokenResponse, completion: @escaping (Result<Void, Error>) -> Void) {
        self.callbackObserver = NotificationCenter.default.addObserver(forName: .twitterCallback, object: nil, queue: .main) { notification in
            self.callbackObserver = nil // remove notification observer
            guard let url = notification.object as? URL,
                  let parameters = url.query?.urlQueryStringParameters,
                  let verifier = parameters["oauth_verifier"] else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidURLParametrs))
                }
                return
            }
            // Start Step 3: Request Access Token
            let accessTokenInput = RequestAccessTokenInput(consumerKey: TWITTER_CONSUMER_KEY,
                                                     consumerSecret: TWITTER_CONSUMER_SECRET,
                                                     requestToken: oAuthTokenResponse.oauthToken,
                                                     requestTokenSecret: oAuthTokenResponse.oauthTokenSecret,
                                                     oauthVerifier: verifier)
            self.requestAccessToken(args: accessTokenInput) { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        completion(.success(()))
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
                // Process Completed Successfully!
            }
            // Kick off our Step 2 observer: start listening for user login callback in scene delegate (from handleOpenUrl)
        }
    }
    
    func authorize(presentingSafariHandler: @escaping (URL) -> Void, completion: @escaping (Result<Void, Error>) -> Void) {
        // Start Step 1: Requesting an access token
        let oAuthTokenInput = RequestOAuthTokenInput(consumerKey: TWITTER_CONSUMER_KEY,
                                                   consumerSecret: TWITTER_CONSUMER_SECRET,
                                                   callbackScheme: TWITTER_URL_SCHEME)
        requestOAuthToken(args: oAuthTokenInput) { result in
            switch result {
            case .success(let oAuthTokenResponse):
                self.addObserverForTwitterCallback(oAuthTokenResponse: oAuthTokenResponse, completion: completion)
                
                // Start Step 2: User Twitter Login
                let urlString = "https://api.twitter.com/oauth/authorize?oauth_token=\(oAuthTokenResponse.oauthToken)"
                guard let oauthUrl = URL(string: urlString) else {
                    DispatchQueue.main.async {
                        completion(.failure(.invalidURL))
                    }
                    return
                }
                DispatchQueue.main.async {
                    presentingSafariHandler(oauthUrl)// sets our safari view url
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func handleUrl(_ url: URL) {
        guard let urlScheme = url.scheme,
              urlScheme == TWITTER_URL_SCHEME else {
            return
        }
        let notification = Notification(name: .twitterCallback, object: url, userInfo: nil)
        NotificationCenter.default.post(notification)
    }
    
}
