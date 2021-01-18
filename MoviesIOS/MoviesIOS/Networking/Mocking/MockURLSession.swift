//
//  MockURLSession.swift
//  MoviesIOS
//
//  Created by Rhulani Ndhlovu on 2021/01/07.
//

import Foundation

class MockURLSession : URLSession {
 
    var cachedUrl: URL?
    private let mockTask: MockTask
    
    init(data: Data?, cachedUrl: URL, urlResponse: URLResponse?, error: Error?) {
        self.cachedUrl = cachedUrl
        mockTask = MockTask(data: data, urlResponse: urlResponse, mockError:error)
    }
    
}
