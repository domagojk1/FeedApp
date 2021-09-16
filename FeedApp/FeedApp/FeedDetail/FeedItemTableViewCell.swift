//
//  FeedItemTableViewCell.swift
//  FeedApp
//
//  Created by Domagoj on 16.09.2021..
//

import UIKit

class FeedItemTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        textLabel?.font = .preferredFont(forTextStyle: .title1)
        textLabel?.numberOfLines = 0
        detailTextLabel?.font = .preferredFont(forTextStyle: .body)
        detailTextLabel?.numberOfLines = 0
    }

    func setup(with feedItem: FeedItem) {
        textLabel?.text = feedItem.title
        detailTextLabel?.text = feedItem.description
    }
}
