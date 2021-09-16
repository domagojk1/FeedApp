//
//  RSSFeeds.swift
//  FeedApp
//
//  Created by Domagoj on 15.09.2021..
//

import Foundation

struct RSSFeed {
    let link: String

    static var all: [RSSFeed] = [
        .init(link: "https://www.skysports.com/rss/12040"),
        .init(link: "https://www.espn.com/espn/rss/nba/news"),
        .init(link: "https://www.sportsengine.com/rss/api/v1/articles?sport=american%20football&type=xml"),
        .init(link: "https://www.theguardian.com/sport/blog/rss"),
        .init(link: "https://franchisesports.co.uk/feed/")
    ]
}
