//
//  MainCoordinator.swift
//  FeedApp
//
//  Created by Domagoj on 15.09.2021..
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let feedsVC = FeedsViewController.instantiate()
        feedsVC.viewModel = FeedsViewModel(feedsDataSource: FeedsDataSource())
        navigationController.pushViewController(feedsVC, animated: false)
    }
}
