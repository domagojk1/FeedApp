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

    private let rssFetcher: RSSFetchable

    init(rssFetcher: RSSFetchable) {
        self.rssFetcher = rssFetcher
    }

    func load(feed: RSSFeed) -> Single<FeedModel> {
        Single.create { [weak self] single in
            guard let self = self else {
                single(.failure(FeedError.failedToParseRSS))
                return Disposables.create()
            }

            guard let url = self.rssFetcher.validURL(for: feed) else {
                single(.failure(FeedError.failedToLoadURL))
                return Disposables.create()
            }

            self.rssFetcher.fetchFeed(from: url) { result in
                switch (result) {
                case .success(let feed):
                    single(.success(feed))
                case .failure(let error):
                    single(.failure(error))
                }
            }

            return Disposables.create()
        }
    }
}
