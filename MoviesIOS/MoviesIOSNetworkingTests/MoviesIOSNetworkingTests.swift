//
//  MoviesIOSNetworkingTests.swift
//  MoviesIOSNetworkingTests
//
//  Created by Rhulani Ndhlovu on 2021/01/06.
//

import XCTest
@testable import MoviesIOS

class MoviesIOSNetworkingTests: XCTestCase {

    var sut: MoviesAPIClient!
    var jsonData: Data?
    var url: URL?
    
    override func setUp() {
        super.setUp()
        sut = MoviesAPIClient()
        jsonData =  "{\"movies\": { \"backdrop\":\"https://wookie.codesubmit.io/static/backdrops/d6822b7b-48bb-4b78-ad5e-9ba04c517ec8.jpg\"}}".data(using: .utf8)
        url = URL(string: Constants.API_BASE_URL+Constants.MOVIES_ENDPOINT)
    }
    
    override func tearDown() {
        sut = nil
        jsonData = nil
        url = nil
        
        super.tearDown()
    }
    
    
    // MARK:- Test Case 1
    func testGetMoviesWithExpectedURLHostAndPath() {
        // given
        
        let mockURLSession = MockURLSession(data: jsonData, cachedUrl: url!, urlResponse: nil, error: nil)
            sut.session = mockURLSession
            
            sut.getMovies { (movies) in
            } errorHandler: { (error) in
                
        }

        XCTAssertEqual(mockURLSession.cachedUrl?.host, "wookie.codesubmit.io")
        XCTAssertEqual(mockURLSession.cachedUrl?.path, "/movies")
    }
    
    // MARK:- Test Case 2
    func testGetMoviesSuccessReturnsMovies() {
        // given
        
        let mockURLSession = MockURLSession(data: jsonData, cachedUrl: url!, urlResponse: nil, error: nil)
        sut.session = mockURLSession
        
        let moviesExpectation = expectation(description: "movies")
        var moviesResponse: Movies?
        
        sut.getMovies { (movies) in
            moviesResponse = movies
            moviesExpectation.fulfill()
        } errorHandler: { (error) in
            
        }
        
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNotNil(moviesResponse)
        }
    }
    
    // MARK:- Test 3
    func testGetMoviesWhenResponseErrorReturnsError() {
        
        let error = NSError(domain: "error", code: 1234, userInfo: nil)
        let mockURLSession = MockURLSession(data: nil, cachedUrl: url!, urlResponse: nil, error: error)
        sut.session = mockURLSession
        let errorExpectation = expectation(description: "error")
        var errorResponse: Error?
        
        sut.getMovies { (movies) in
            errorResponse = error
                errorExpectation.fulfill()
        } errorHandler: { (error) in
            errorResponse = error
                errorExpectation.fulfill()
        }
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNotNil(errorResponse)
        }
        
    }

}
