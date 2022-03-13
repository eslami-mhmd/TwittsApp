//
//  TwittsAppTests.swift
//  TwittsAppTests
//
//  Created by Mohammad Eslami on 3/13/22.
//

import XCTest
@testable import TwittsApp

class TwittsListViewModelTests: XCTestCase {
    private var repo: TwittsRepositoryMock!
    private var viewModel: TwittsListViewModel!

    @MainActor override func setUp() {
        super.setUp()
        repo = TwittsRepositoryMock(remoteAPI: RemoteAPIMock())
        viewModel = TwittsListViewModel(twittsRepository: repo)
    }

    func testFetchTwitts() {
        viewModel.fetchTwitts()

        let exp = expectation(description:
                                "after some delay check if twitts received in view model.Then check sort is correct")
        let result = XCTWaiter.wait(for: [exp], timeout: 0.1)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(viewModel.twitts.count, 10)

            if let firstData = viewModel.twitts[0].data?.identifier, let firstId = Int(firstData),
               let lastData = viewModel.twitts[9].data?.identifier, let lastId = Int(lastData) {
                XCTAssertTrue(firstId > lastId)
            }
        } else {
            XCTFail("Delay interrupted")
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
