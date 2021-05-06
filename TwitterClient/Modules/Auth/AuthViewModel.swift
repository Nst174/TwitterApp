//
//  AuthViewModel.swift
//  TwitterClient
//
//  Created by Marat Khuzhayarov on 04.03.2021.
//

import Foundation

protocol AuthViewModelInterfacce {
    
}

class AuthViewModel: AuthViewModelInterfacce {
    
    private let twitterAuthService: TwitterAuthService
    
    // MARK: Initialization
    required init(twitterAuthService: TwitterAuthService) {
        self.twitterAuthService = twitterAuthService
    }

}
