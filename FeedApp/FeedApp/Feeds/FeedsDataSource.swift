//
//  FeedsDataSource.swift
//  FeedApp
//
//  Created by Domagoj on 15.09.2021..
//

import Foundation
import RxSwift
import FeedKit

final class FeedsDataSource {

    func load(feeds: [RSSFeed]) -> Single<[FeedModel]> {
        let feeds = feeds.map { load(feed: $0) }
        return Single.zip(feeds)
    }

    func load(feed: RSSFeed) -> Single<FeedModel> {
        Single.create { single in
            guard let url = URL(string: feed.rawValue) else {
                single(.failure(FeedError.failedToLoadURL))
                return Disposables.create()
            }

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
                        single(.success(model))
                    } else {
                        single(.failure(FeedError.failedToParseRSS))
                    }
                case .failure(let error):
                    single(.failure(error))
                }
            }

            return Disposables.create()
        }
    }
}
