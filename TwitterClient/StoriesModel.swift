//
//  StoriesModel.swift
//  TwitterClient
//
//  Created by OUT-Dobrolyubov1-NN on 19.03.2021.
//

import UIKit

struct StoriesModel {
    var image: UIImage?
}


class StoriesAPI {
    static func getStories() -> [StoriesModel] {
        let stories = [
            StoriesModel(image: UIImage(named: "@Apple")),
            StoriesModel(image: UIImage(named: "@Rhymeslive"))
        ]
        return stories
    }
}
