//
//  PlayerListTests.swift
//  GreatSportsTests
//
//  Created by Russel Dev on 28/07/23.
//

import XCTest
@testable import GreatSports

final class PlayerListTests: XCTestCase {

    var sut: PlayerListViewModel?
    var playerListingMockAPIService: PlayerListingMockAPIService!
    
    override func setUp() {
        super.setUp()
        sut = PlayerListViewModel()
        playerListingMockAPIService = PlayerListingMockAPIService()
        sut = PlayerListViewModel(apiService: playerListingMockAPIService)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFetchPlayers() {

        // Given A API Model
        let sut = self.sut!
        
        let expect = XCTestExpectation(description: "callback")
        // When
        sut.fetchPlayerList(params: [:]) { dataObject in
            expect.fulfill()
            // Then
            XCTAssertNotEqual( dataObject.value?.data?.count, 0)
            for player in dataObject.value?.data ?? [] {
                XCTAssertNotNil(player.id)
            }
        }
        
        wait(for: [expect], timeout: 1)
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
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
