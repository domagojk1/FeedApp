//
//  FeedModel.swift
//  FeedApp
//
//  Created by Domagoj on 15.09.2021..
//

import Foundation

struct FeedModel: Hashable {
    let title: String?
    let description: String?
    let imageLink: String?
    let link: String?

    var imageURL: URL? {
        URL(string: imageLink ?? "")
    }
}
