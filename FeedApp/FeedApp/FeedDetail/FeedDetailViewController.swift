//
//  FeedDetailViewController.swift
//  FeedApp
//
//  Created by Domagoj on 16.09.2021..
//

import UIKit
import SnapKit
import RxSwift
import RxDataSources

class FeedDetailViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(FeedItemTableViewCell.self, forCellReuseIdentifier: reuseId)
        return tableView
    }()

    private let reuseId = "FeedItemCellId"
    private let disposeBag = DisposeBag()
    private let viewModel: FeedDetailViewModel

    init(viewModel: FeedDetailViewModel) {
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

// MARK: UI

private extension FeedDetailViewController {

    func configureUI() {
        view.addSubview(tableView)
        tableView.pinEdges(to: view)
    }
}

// MARK: - Bindings

private extension FeedDetailViewController {

    func configureBindings() {
        viewModel.items.drive(tableView.rx.items(cellIdentifier: reuseId)) { _, feedItem, cell in
            guard let cell = cell as? FeedItemTableViewCell else { return }
            cell.setup(with: feedItem)
        }.disposed(by: disposeBag)

        tableView.rx.modelSelected(FeedItem.self)
            .bind(to: viewModel.feedSelectedPublisher)
            .disposed(by: disposeBag)

        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
        }).disposed(by: disposeBag)
    }
}
