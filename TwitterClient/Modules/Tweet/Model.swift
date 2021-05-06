//
//  Tweet.swift
//  TwitterClient
//
//  Created by 18574230 on 12.03.2021.
//
import UIKit
import Foundation

struct Story {
    let profileImageName: String
    let profileName: String
}

struct Tweet {
    let userRealName: String
    let userName: String
    let userImage: UIImage
    let userMessage: String
    let messageImageName: String?
}

struct TitleDTO {
    let menuImageName: String
    let twitterImage: String
    let starImage: String
}

struct StoriesDTO {
    let storiesList: [Story] = []
}

struct TweetDTO {
    let tweetsList: [Tweet] = []
}

enum RowItem {
    case title(TitleDTO)
    case stories([Story])
    case tweets(Tweet)
}
