//
//  FeedViewModelTests.swift
//  FeedAppTests
//
//  Created by Domagoj on 16.09.2021..
//

import XCTest
import RxSwift
import RxTest
import RxCocoa
import RxBlocking

@testable import FeedApp

class FeedViewModelTests: XCTestCase {

    private var scheduler: TestScheduler!
    private var bag: DisposeBag!

    override func setUp() {
        bag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
    }

    func testFeedsFailedAndReturnedAsEmptyWhenBadURL() {
        let fetcher = RSSFetcherMock(shouldFail: false, shouldFailWithBadURL: true)
        let dataSource = FeedsDataSource(rssFetcher: fetcher)
        let viewModel = FeedsViewModel(feedsDataSource: dataSource, coordinator: FeedsCoordinator(navigationController: UINavigationController()))

        let expectedEvents = Recorded.events([.next(0, [FeedModel]()), .completed(0)])
        let feedModelsObservable = scheduler.createObserver([FeedModel].self)

        viewModel.feeds.drive(feedModelsObservable).disposed(by: bag)
        scheduler.start()

        XCTAssertEqual(expectedEvents, feedModelsObservable.events)
    }

    func testFeedsFailedAndReturnedAsEmptyWhenFailedToParse() {
        let fetcher = RSSFetcherMock(shouldFail: true, shouldFailWithBadURL: false)
        let dataSource = FeedsDataSource(rssFetcher: fetcher)
        let viewModel = FeedsViewModel(feedsDataSource: dataSource, coordinator: FeedsCoordinator(navigationController: UINavigationController()))

        let expectedEvents = Recorded.events([.next(0, [FeedModel]()), .completed(0)])
        let feedModelsObservable = scheduler.createObserver([FeedModel].self)

        viewModel.feeds.drive(feedModelsObservable).disposed(by: bag)
        scheduler.start()

        XCTAssertEqual(expectedEvents, feedModelsObservable.events)
    }

    func testFeedsReturnedWhenParserIsSuccessful() {
        let fetcher = RSSFetcherMock(shouldFail: false, shouldFailWithBadURL: false)
        let dataSource = FeedsDataSource(rssFetcher: fetcher)
        let feeds = [RSSFeed(link: "link1"), RSSFeed(link: "link2")]
        let viewModel = FeedsViewModel(feedsDataSource: dataSource,
                                       coordinator: FeedsCoordinator(navigationController: UINavigationController()),
                                       rssFeeds: feeds)

        let expectedEvents = Recorded.events([.next(0, [RSSFetcherMock.feedModelMock, RSSFetcherMock.feedModelMock]), .completed(0)])
        let feedModelsObservable = scheduler.createObserver([FeedModel].self)

        viewModel.feeds.drive(feedModelsObservable).disposed(by: bag)
        scheduler.start()

        XCTAssertEqual(expectedEvents, feedModelsObservable.events)
    }
}

