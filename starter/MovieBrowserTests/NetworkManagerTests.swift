//
//  NetworkManagerTests.swift
//  MovieBrowserTests
//
//  Created by Conner Maddalozzo on 12/10/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import XCTest
@testable import MovieBrowser

class NetworkManagerTests: XCTestCase {

    var networkManager: NetworkManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.networkManager = NetworkManager(session: MockSession())
    }

    override func tearDownWithError() throws {
        self.networkManager = nil
        try super.tearDownWithError()
    }

    func testGetModelSuccess() {
        let expectation = XCTestExpectation(description: "Success")
        var movies: [Movie]?
        
        self.networkManager.getModel(url: URL(string: "https://Victory.com")) { (result: Result<PageResult, Error>) in
            switch result {
            case .success(let page):
                movies = page.results
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 3.0)
        
        XCTAssertEqual(movies?.count, 20)
        XCTAssertEqual(movies?.first?.title, "Harry Potter and the Philosopher's Stone")
        XCTAssertEqual(movies?.first?.releaseDate, "2001-11-16")
        XCTAssertEqual(movies?.first?.rating, 7.9)
        XCTAssertEqual(movies?.first?.overview, "Harry Potter has lived under the stairs at his aunt and uncle's house his whole life. But on his 11th birthday, he learns he's a powerful wizard—with a place waiting for him at the Hogwarts School of Witchcraft and Wizardry. As he learns to harness his newfound powers with the help of the school's kindly headmaster, Harry uncovers the truth about his parents' deaths—and about the villain who's to blame.")
        
    }
    
    func testGetModelFail() {
        let expectation = XCTestExpectation(description: "Failed to get data")
        var err: NetworkError?
        
        self.networkManager.getModel(url: URL(string: "https://Fail.org")) { (result: Result<PageResult, Error>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                err = error as? NetworkError
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 3.0)
        
        XCTAssertEqual(err, NetworkError.dataFailure)
    }


}
