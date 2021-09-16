//
//  FeedError.swift
//  FeedApp
//
//  Created by Domagoj on 15.09.2021..
//

import Foundation

enum FeedError: Error {
    case failedToLoadURL
    case failedToParseRSS
}
