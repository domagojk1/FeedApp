//
//  RSSFetcherMock.swift
//  FeedAppTests
//
//  Created by Domagoj on 16.09.2021..
//

import Foundation
@testable import FeedApp

final class RSSFetcherMock: RSSFetchable {

    private let shouldFail: Bool
    private let shouldFailWithBadURL: Bool
    static let feedModelMock = FeedModel(title: "title",
                                         description: "description",
                                         imageLink: "imageLink",
                                         link: "link",
                                         items: [FeedItem(title: "title",
                                                          link: "link",
                                                          description: "desc")])

    init(shouldFail: Bool, shouldFailWithBadURL: Bool) {
        self.shouldFail = shouldFail
        self.shouldFailWithBadURL = shouldFailWithBadURL
    }

    func validURL(for feed: RSSFeed) -> URL? {
        if shouldFailWithBadURL {
            return nil
        }
        return URL(string: feed.link)
    }

    func fetchFeed(from url: URL, completion: @escaping ((Result<FeedModel, FeedError>) -> Void)) {
        if shouldFail {
            completion(.failure(FeedError.failedToParseRSS))
        } else {
            completion(.success(Self.feedModelMock))
        }
    }
}
