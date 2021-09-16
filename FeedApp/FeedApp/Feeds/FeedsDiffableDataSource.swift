//
//  FeedsDiffableDataSource.swift
//  FeedApp
//
//  Created by Domagoj on 16.09.2021..
//

import UIKit

enum FeedSection: CaseIterable {
    case main
}

final class FeedsDiffableDataSource: UITableViewDiffableDataSource<FeedSection, FeedModel>, UITableViewDelegate {

    private var didSelectItem: ((Int) -> Void)?

    init(tableView: UITableView,
         cellProvider: @escaping UITableViewDiffableDataSource<FeedSection, FeedModel>.CellProvider,
         didSelectItem: ((Int) -> Void)?) {
        self.didSelectItem = didSelectItem
        super.init(tableView: tableView, cellProvider: cellProvider)
        tableView.delegate = self
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectItem?(indexPath.row)
    }
}
