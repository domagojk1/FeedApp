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
    let feedSelectionPublisher = PublishSubject<Int>()

    private let feedsDataSource: FeedsDataSource
    private let disposeBag = DisposeBag()

    init(feedsDataSource: FeedsDataSource) {
        self.feedsDataSource = feedsDataSource
        feeds = feedsDataSource.load(feeds: RSSFeed.allCases).asDriver(onErrorJustReturn: [])

        Driver.combineLatest(feeds, feedSelectionPublisher.asDriver(onErrorDriveWith: .empty())) { ($0, $1) }
            .drive(onNext: { [weak self] (feedModels, selectedIndex) in
                self?.didSelect(feedModel: feedModels[selectedIndex])
            })
            .disposed(by: disposeBag)
    }

    private func didSelect(feedModel: FeedModel) {
        print("didSelect \(feedModel)")
    }
}
