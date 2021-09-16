//
//  RSSFeeds.swift
//  FeedApp
//
//  Created by Domagoj on 15.09.2021..
//

import Foundation

enum RSSFeed: String, CaseIterable {
    case skySports = "https://www.skysports.com/rss/12040"
    case espn = "https://www.espn.com/espn/rss/nba/news"
    case sportsEngine = "https://www.sportsengine.com/rss/api/v1/articles?sport=american%20football&type=xml"
    case sportsCrunch = "https://www.sportscrunch.in/feed/"
    case guardian = "https://www.theguardian.com/sport/blog/rss"
    case franchiseSports = "https://franchisesports.co.uk/feed/"
}
