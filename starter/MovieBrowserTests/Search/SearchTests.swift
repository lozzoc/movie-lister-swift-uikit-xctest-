//
//  SearchTests.swift
//  MovieBrowserTests
//
//  Created by Conner Maddalozzo on 01/12/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import XCTest
@testable import MovieBrowser

class SearchTests: XCTestCase {

    let mockId: Int = 1
    let mockPsterImage: String = "mockImageurl"
    let mockTitle: String = "mockTitle"
    let mockRating: Double = 5.0
    let mockReleaseDate: String = ""
    let mockOverview: String = "Mock overview super cool"
    let mockPageCount: Int = 1

    var vm: SearchViewModel?
    override func setUpWithError() throws {
        
        // we only care that it can handle the result...
        let mockNC = mockNetworkCallerPageResult()
        mockNC.mockReturnModelPage = PageResult(page: 1, totalResults: mockPageCount, totalPages: 1, results: [Movie(id: mockId, posterImage: mockPsterImage, title: mockTitle, rating: mockRating, releaseDate: mockReleaseDate, overview: mockOverview)])
        vm = SearchViewModel(networkCaller: mockNC)
        
    }
    
    func testGetDetailForItem() {
        //given
        let expectation = expectation(description: "When search function is over, it should contain a list of results")
        vm?.bind {
            guard let item = self.vm?.createMovieViewModel(for: 0) else {
                XCTFail()
                return
            }
            //then
            XCTAssertEqual(self.vm?.count, self.mockPageCount)
            XCTAssertEqual(item.movieTitle(), self.mockTitle)
            
            expectation.fulfill()
        }
        //when
        vm?.searchMovies(with: "asdf")

        
        wait(for: [expectation], timeout: 1)

    }
 
}


class mockNetworkCallerPageResult: NetworkCaller {
    var mockReturnModelPage: PageResult?
    
    func getModel<T>(url: URL?, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        guard let result = mockReturnModelPage else {
            completion(.failure(NetworkError.dataFailure))
            return
        }
        completion(.success(result as! T))
    }
    
    func getData(url: URL?, completion: @escaping (Result<Data, Error>) -> Void) {
        
    }
    
    
}
