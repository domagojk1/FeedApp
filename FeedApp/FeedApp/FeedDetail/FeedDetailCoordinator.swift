//
//  FeedDetailCoordinator.swift
//  FeedApp
//
//  Created by Domagoj on 16.09.2021..
//

import UIKit

final class FeedDetailCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private let feedModel: FeedModel

    init(navigationController: UINavigationController, feedModel: FeedModel) {
        self.navigationController = navigationController
        self.feedModel = feedModel
    }

    func start() {
        let viewModel = FeedDetailViewModel(feedModel: feedModel, coordinator: self)
        let feedDetailVC = FeedDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(feedDetailVC, animated: true)
    }


    func open(feedItem: FeedItem) {
        let viewModel = WebViewModel(feedItem: feedItem)
        let webViewVC = WebViewController(viewModel: viewModel)
        navigationController.pushViewController(webViewVC, animated: true)
    }
}
