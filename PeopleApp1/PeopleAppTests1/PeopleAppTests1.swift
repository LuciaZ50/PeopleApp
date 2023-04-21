//
//  PeopleAppTests1.swift
//  PeopleAppTests1
//
//  Created by LuciaDecode on 23.12.2022..
//

import XCTest
@testable import PeopleApp

final class PeopleAppTests1: XCTestCase {
    
    var sut: HomeViewModel?

    @MainActor override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = HomeViewModel(service: Service())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
    }

    @MainActor func test_getPeopleFetches() async throws {
        
        try await sut?.getPeople(atPage: "1")
        let users = sut?.people
                
        XCTAssertTrue(users!.count > 0)
        }
    }

