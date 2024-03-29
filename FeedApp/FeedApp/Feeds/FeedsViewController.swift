//
//  FeedsViewController.swift
//  FeedApp
//
//  Created by Domagoj on 15.09.2021..
//

import UIKit
import SnapKit
import RxSwift
import RxDataSources

class FeedsViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(RSSFeedTableViewCell.self, forCellReuseIdentifier: reuseId)
        return tableView
    }()

    private let reuseId = "FeedModelCellId"
    private let disposeBag = DisposeBag()
    private let viewModel: FeedsViewModel

    init(viewModel: FeedsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title
        configureUI()
        configureBindings()
    }
}

// MARK: - UI

private extension FeedsViewController {

    func configureUI() {
        view.addSubview(tableView)
        tableView.pinEdges(to: view)
    }
}

// MARK: - Bindings

private extension FeedsViewController {

    func configureBindings() {
        viewModel.feeds.drive(tableView.rx.items(cellIdentifier: reuseId)) { _, feedModel, cell in
            guard let cell = cell as? RSSFeedTableViewCell else { return }
            cell.setup(with: feedModel)
        }.disposed(by: disposeBag)

        tableView.rx.modelSelected(FeedModel.self)
            .bind(to: viewModel.feedSelectionPublisher)
            .disposed(by: disposeBag)

        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
        }).disposed(by: disposeBag)
    }
}
