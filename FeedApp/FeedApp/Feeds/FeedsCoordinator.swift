//
//  MainCoordinator.swift
//  FeedApp
//
//  Created by Domagoj on 15.09.2021..
//

import UIKit

class FeedsCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = FeedsViewModel(feedsDataSource: FeedsDataSource(rssFetcher: RSSFetcher()),
                                       coordinator: self)
        let feedsVC = FeedsViewController(viewModel: viewModel)
        navigationController.pushViewController(feedsVC, animated: false)
    }

    func navigate(to feedModel: FeedModel) {
        let coordinator = FeedDetailCoordinator(navigationController: navigationController, feedModel: feedModel)
        coordinator.start()
    }
}
