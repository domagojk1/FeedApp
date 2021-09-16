//
//  FeedDetailViewModel.swift
//  FeedApp
//
//  Created by Domagoj on 16.09.2021..
//

import Foundation
import RxSwift
import RxCocoa

final class FeedDetailViewModel {

    var items: Driver<[FeedItem]> { .just(feedModel.items ?? []) }
    var title: String { feedModel.title ?? "" }
    let feedSelectedPublisher = PublishSubject<FeedItem>()

    private let coordinator: FeedDetailCoordinator
    private let feedModel: FeedModel
    private let disposeBag = DisposeBag()

    init(feedModel: FeedModel, coordinator: FeedDetailCoordinator) {
        self.feedModel = feedModel
        self.coordinator = coordinator

        feedSelectedPublisher.asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] item in
                self?.didSelect(feedItem: item)
            })
            .disposed(by: disposeBag)
    }

    private func didSelect(feedItem: FeedItem) {
        coordinator.open(feedItem: feedItem)
    }
}
