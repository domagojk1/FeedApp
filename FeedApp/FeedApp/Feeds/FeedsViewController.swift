//
//  FeedsViewController.swift
//  FeedApp
//
//  Created by Domagoj on 15.09.2021..
//

import UIKit
import SnapKit
import RxSwift

class FeedsViewController: UIViewController, Storyboarded {
    
    private lazy var dataSource: FeedsDiffableDataSource = {
        let reuseId = reuseId
        return FeedsDiffableDataSource(tableView: tableView) { tableView, indexPath, feedModel in
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as? FeedTableViewCell
            cell?.setup(with: feedModel)
            return cell
        } didSelectItem: { [weak self] itemSelected in
            self?.viewModel.feedSelectionPublisher.onNext(itemSelected)
        }
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: reuseId)
        return tableView
    }()

    private let reuseId = "FeedModelCellId"
    private let disposeBag = DisposeBag()
    var viewModel: FeedsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        tableView.dataSource = dataSource

        viewModel.feeds.drive(onNext: { [weak self] feedItems in
            self?.updateFeed(with: feedItems)
        }).disposed(by: disposeBag)
    }
}

// MARK: - UI

private extension FeedsViewController {

    func configureUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        tableView.pinEdges(to: view)
    }
}

// MARK: - UITableView

private extension FeedsViewController {

    func updateFeed(with feedItems: [FeedModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<FeedSection, FeedModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(feedItems, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
