//
//  UIView+Extension.swift
//  FeedApp
//
//  Created by Domagoj on 15.09.2021..
//

import UIKit
import SnapKit

extension UIView {

    func pinEdges(to superView: UIView, horizontaInset: CGFloat = 0, verticalInset: CGFloat = 0) {
        snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(horizontaInset)
            make.top.equalToSuperview().inset(verticalInset)
            make.trailing.equalToSuperview().inset(horizontaInset)
            make.bottom.equalToSuperview().inset(verticalInset)
        }
    }
}

