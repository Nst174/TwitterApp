//
//  PostModel.swift
//  TwitterClient
//
//  Created by OUT-Dobrolyubov1-NN on 18.03.2021.
//

import UIKit

struct PostModel {
    let name: String?
    let username: String?
    let postText: String?
}

class PostAPI {
    static func getPosts() -> [PostModel] {
        let posts = [
            PostModel(name: "Apple", username: "@"+"Apple", postText: "Отслеживай свои тренировки - даже под водой."),
            PostModel(name: "Рифмы и Панчи", username: "@"+"Rhymeslive", postText: "Кто обзывается, сам так называется\nВова, 68 лет")]
        return posts
    }
}
