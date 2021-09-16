//
//  Coordinator.swift
//  FeedApp
//
//  Created by Domagoj on 15.09.2021..
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
