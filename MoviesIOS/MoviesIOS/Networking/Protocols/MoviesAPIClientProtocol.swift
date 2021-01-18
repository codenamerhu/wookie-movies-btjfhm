//
//  MoviesAPIClientProtocol.swift
//  MoviesIOS
//
//  Created by Rhulani Ndhlovu on 2021/01/07.
//

import Foundation

protocol MoviesAPIClientProtocol {
    func getMovies(params: [String: String]?, successHandler: @escaping (_ response: Movies) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
    func searchMovie(query: String, params: [String: String]?, successHandler: @escaping (_ response: Movies) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
}

public enum Endpoint: String, CustomStringConvertible, CaseIterable {
    case movies = "movies"
    
    public var description: String {
        switch self {
        case .movies: return "Movies"
        }
    }
    
    public init?(index: Int) {
        switch index {
        case 0: self = .movies
        default: return nil
        }
    }
    
    public init?(description: String) {
        guard let first = Endpoint.allCases.first(where: { $0.description == description }) else {
            return nil
        }
        self = first
    }
    
}
