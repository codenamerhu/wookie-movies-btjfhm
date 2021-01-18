//
//  MovieError.swift
//  MoviesIOS
//
//  Created by Rhulani Ndhlovu on 2021/01/07.
//

import Foundation

public enum MovieError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}
