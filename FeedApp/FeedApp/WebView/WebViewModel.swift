//
//  WebViewModel.swift
//  FeedApp
//
//  Created by Domagoj on 16.09.2021..
//

import Foundation

final class WebViewModel {

    private let feedItem: FeedItem

    var urlRequest: URLRequest? {
        guard let url = URL(string: feedItem.link ?? "") else { return nil }
        return URLRequest(url: url)
    }

    var title: String { feedItem.title ?? "" }

    init(feedItem: FeedItem) {
        self.feedItem = feedItem
    }
}
