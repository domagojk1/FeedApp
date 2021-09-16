//
//  FeedModel.swift
//  FeedApp
//
//  Created by Domagoj on 15.09.2021..
//

import Foundation

struct FeedItem: Hashable {
    let title: String?
    let link: String?
    let description: String?
}

struct FeedModel: Hashable {
    let title: String?
    let description: String?
    let imageLink: String?
    let link: String?
    let items: [FeedItem]?

    var imageURL: URL? {
        URL(string: imageLink ?? "")
    }
}
