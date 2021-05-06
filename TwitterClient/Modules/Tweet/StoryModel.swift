//
//  StoryModel.swift
//  TwitterClient
//
//  Created by 18574230 on 23.03.2021.
//

import Foundation
import UIKit

struct StoriesModel {
    var image: UIImage?
}


class StoriesAPI {
    static func getStories() -> [StoriesModel] {
        let stories = [
            StoriesModel(image: UIImage(named: "Nikita.png")),
            StoriesModel(image: UIImage(named: "Eduard.png")),
            StoriesModel(image: UIImage(named: "Nikita.png")),
            StoriesModel(image: UIImage(named: "Eduard.png")),
            StoriesModel(image: UIImage(named: "Nikita.png")),
            StoriesModel(image: UIImage(named: "Eduard.png")),
            StoriesModel(image: UIImage(named: "Nikita.png")),
            StoriesModel(image: UIImage(named: "Eduard.png")),
            StoriesModel(image: UIImage(named: "Nikita.png")),
            StoriesModel(image: UIImage(named: "Eduard.png")),
            StoriesModel(image: UIImage(named: "Nikita.png")),
            StoriesModel(image: UIImage(named: "Eduard.png")),
        ]
        return stories
    }
}
