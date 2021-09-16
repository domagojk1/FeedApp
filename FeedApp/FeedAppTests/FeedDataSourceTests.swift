//
//  FeedAppTests.swift
//  FeedAppTests
//
//  Created by Domagoj on 15.09.2021..
//

import XCTest
import RxSwift
import RxTest
import RxCocoa
import RxBlocking

@testable import FeedApp

class FeedDataSourceTests: XCTestCase {

    private var bag: DisposeBag!

    override func setUp() {
        bag = DisposeBag()
    }

    func testFeedFetchFailsWhenBadURL() {
        let fetcher = RSSFetcherMock(shouldFail: false, shouldFailWithBadURL: true)
        let dataSource = FeedsDataSource(rssFetcher: fetcher)

        let expectedResult: [FeedModel] = []
        let result = dataSource.load(feed: RSSFeed(link: "link"))
            .toBlocking()
            .materialize()

        let expectedError = FeedError.failedToLoadURL

        switch result {
        case .completed:
            XCTFail("Expected result to complete with error")
        case .failed(let elements, let error):
            XCTAssertEqual(elements, expectedResult)
            XCTAssertEqual(error as! FeedError, expectedError)
        }
    }

    func testFeedFetchFailsWhenFailedParsing() {
        let fetcher = RSSFetcherMock(shouldFail: true, shouldFailWithBadURL: false)
        let dataSource = FeedsDataSource(rssFetcher: fetcher)

        let expectedResult: [FeedModel] = []
        let result = dataSource.load(feed: RSSFeed(link: "link"))
            .toBlocking()
            .materialize()

        let expectedError = FeedError.failedToParseRSS

        switch result {
        case .completed:
            XCTFail("Expected result to complete with error")
        case .failed(let elements, let error):
            XCTAssertEqual(elements, expectedResult)
            XCTAssertEqual(error as! FeedError, expectedError)
        }
    }

    func testFeedFetchSucceeds() {
        let fetcher = RSSFetcherMock(shouldFail: false, shouldFailWithBadURL: false)
        let dataSource = FeedsDataSource(rssFetcher: fetcher)

        let expectedResult: [FeedModel] = [RSSFetcherMock.feedModelMock]
        let result = dataSource.load(feed: RSSFeed(link: "link"))
            .toBlocking()
            .materialize()


        switch result {
        case .completed(let elements):
            XCTAssertEqual(elements, expectedResult)
        case .failed:
            XCTFail("Expected to complete with success")
        }
    }
}
