//
//  FeedsViewModel.swift
//  FeedApp
//
//  Created by Domagoj on 15.09.2021..
//

import FeedKit
import Foundation
import RxSwift
import RxCocoa

final class FeedsViewModel {

    let feeds: Driver<[FeedModel]>
    let feedSelectionPublisher = PublishSubject<FeedModel>()
    let title = "RSS Feeds"

    private let coordinator: FeedsCoordinator
    private let feedsDataSource: FeedsDataSource
    private let disposeBag = DisposeBag()

    init(feedsDataSource: FeedsDataSource,
         coordinator: FeedsCoordinator,
         rssFeeds: [RSSFeed] = RSSFeed.all) {
        self.feedsDataSource = feedsDataSource
        self.coordinator = coordinator

        let feedsSource = rssFeeds.map { feedsDataSource.load(feed: $0) }
        feeds = Single.zip(feedsSource).asDriver(onErrorJustReturn: [])

        feedSelectionPublisher
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] model in
                self?.didSelect(feedModel: model)
            }).disposed(by: disposeBag)
    }

    private func didSelect(feedModel: FeedModel) {
        coordinator.navigate(to: feedModel)
    }
}
