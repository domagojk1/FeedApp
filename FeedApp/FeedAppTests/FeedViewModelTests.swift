//
//  FeedViewModelTests.swift
//  FeedAppTests
//
//  Created by Domagoj on 16.09.2021..
//

import XCTest
import RxSwift
import RxTest
import RxCocoa
import RxBlocking

@testable import FeedApp

class FeedViewModelTests: XCTestCase {

    private var scheduler: TestScheduler!
    private var bag: DisposeBag!

    override func setUp() {
        bag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
    }
}

