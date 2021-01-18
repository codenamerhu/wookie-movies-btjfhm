//
//  MockTask.swift
//  MoviesIOS
//
//  Created by Rhulani Ndhlovu on 2021/01/07.
//

import Foundation

class MockTask: URLSessionDataTask {
  private let data: Data?
  private let urlResponse: URLResponse?
  private let mockError: Error?

  var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
  init(data: Data?, urlResponse: URLResponse?, mockError: Error?) {
    self.data = data
    self.urlResponse = urlResponse
    self.mockError = mockError
  }
  override func resume() {
    DispatchQueue.main.async {
        self.completionHandler!(self.data, self.urlResponse, self.mockError)
    }
  }
}
