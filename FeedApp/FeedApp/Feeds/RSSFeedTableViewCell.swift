//
//  FeedTableViewCell.swift
//  FeedApp
//
//  Created by Domagoj on 15.09.2021..
//

import UIKit
import SnapKit
import Nuke

final class RSSFeedTableViewCell: UITableViewCell {

    private lazy var feedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var feedTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .left
        return label
    }()

    private lazy var feedDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .left
        return label
    }()

    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = Dimensions.itemsVerticalSpacing
        return stack
    }()

    private enum Dimensions {
        static let horizontalPadding: CGFloat = 16
        static let verticalPadding: CGFloat = 32
        static let itemsVerticalSpacing: CGFloat = 6
        static let separatorHeight: CGFloat = 1
        static let imageHeight: CGFloat = 150
    }

    private var imageTask: ImageTask?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageTask?.cancel()
    }

    private func configureUI() {
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = UIColor.lightGray

        contentView.addSubview(stackView)
        stackView.pinEdges(to: stackView,
                           horizontaInset: Dimensions.horizontalPadding,
                           verticalInset: Dimensions.verticalPadding)

        stackView.addArrangedSubview(feedImageView)
        feedImageView.snp.makeConstraints { make in
            make.height.equalTo(Dimensions.imageHeight)
        }

        stackView.addArrangedSubview(separator)
        separator.snp.makeConstraints { make in
            make.height.equalTo(Dimensions.separatorHeight)
        }

        stackView.addArrangedSubview(feedTitleLabel)
        stackView.addArrangedSubview(feedDescriptionLabel)
    }

    func setup(with feed: FeedModel) {
        imageTask = Nuke.loadImage(with: feed.imageURL, into: feedImageView)
        feedTitleLabel.text = feed.title
        feedDescriptionLabel.text = feed.description
    }
}
