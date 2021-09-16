//
//  FeedParser.swift
//  FeedApp
//
//  Created by Domagoj on 16.09.2021..
//

import Foundation
import FeedKit

protocol RSSFetchable {
    func validURL(for feed: RSSFeed) -> URL?
    func fetchFeed(from url: URL, completion: @escaping ((Result<FeedModel, FeedError>) -> Void))
}

extension RSSFetchable {
    func validURL(for feed: RSSFeed) -> URL? {
        URL(string: feed.link)
    }
}

final class RSSFetcher: RSSFetchable {

    func fetchFeed(from url: URL, completion: @escaping ((Result<FeedModel, FeedError>) -> Void)) {
        let parser = FeedParser(URL: url)
        parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { result in
            switch (result) {
            case .success(let feed):
                if let rssFeed = feed.rssFeed {
                    let items = rssFeed.items?.map { FeedItem(title: $0.title, link: $0.link, description: $0.description) }
                    let model = FeedModel(title: rssFeed.title,
                                          description: rssFeed.description,
                                          imageLink: rssFeed.image?.url,
                                          link: rssFeed.link,
                                          items: items)
                    completion(.success(model))
                } else {
                    completion(.failure(.failedToParseRSS))
                }
            case .failure:
                completion(.failure(.failedToParseRSS))
            }
        }
    }
}
