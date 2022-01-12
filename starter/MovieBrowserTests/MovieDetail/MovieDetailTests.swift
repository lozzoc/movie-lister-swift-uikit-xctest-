//
//  MovieDetailTests.swift
//  MovieBrowserTests
//
//  Created by Conner Maddalozzo on 01/12/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import XCTest
@testable import MovieBrowser

class MovieDetailTests: XCTestCase {
    let mockId: Int = 1
    let mockPsterImage: String = "https://placekitten.com/200/200"
    let mockTitle: String = "mockTitle"
    let mockRating: Double = 5.0
    let mockReleaseDate: String = "2001-11-16"
    let mockOverview: String = "Mock overview super cool"
    
    var vm: MovieDetailViewModel?
    let nc = mockNetworkCallerImageLoader()
    
    override func setUpWithError() throws {
        let movie = Movie(id: mockId, posterImage: mockPsterImage, title: mockTitle, rating: mockRating, releaseDate: mockReleaseDate, overview: mockOverview)
        vm = MovieDetailViewModel(movie: movie, formatter: DateFormatter(), networkCaller: nc)
    }
    
    func testGetTitle() {
        guard let vm = self.vm else {
            XCTFail()
            return
        }
        XCTAssertEqual(vm.movieTitle(), mockTitle)
    }
    
    func testGetReleaseDateDetailType() {
        //given
        // mm/dd/yy
        let expectedDateFormat = "11/16/01"
        guard let vm = self.vm else {
            XCTFail()
            return
        }
        
        //then
        XCTAssertEqual(vm.movieReleaseDate(style: .detailView), expectedDateFormat)
    }
    
    func testGetReleaseDateTableView() {
        //given
        // MMM dd, YYYY
        let expectedDateFormat = "November 16, 2001"
        guard let vm = self.vm else {
            XCTFail()
            return
        }
        
        //then
        XCTAssertEqual(vm.movieReleaseDate(style: .searchCell), expectedDateFormat)
    }
    
    func testGetMovieRating() {
        guard let vm = self.vm else {
            XCTFail()
            return
        }
        
        //then
        XCTAssertEqual(vm.movieRating(), "\(mockRating)")
    }
    
    func testGetMovieDescription() {
        guard let vm = self.vm else {
            XCTFail()
            return
        }
        
        //then
        XCTAssertEqual(vm.movieDescription(),mockOverview)
    }

}
class mockNetworkCallerImageLoader: NetworkCaller {
    var getImageHasBeenCalledWith: URL?
    func getModel<T>(url: URL?, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
      
    }
    
    func getData(url: URL?, completion: @escaping (Result<Data, Error>) -> Void) {
        getImageHasBeenCalledWith = url
        completion(.success(Data()))
    }
    
    
}
