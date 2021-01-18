//
//  MoviesAPIClient.swift
//  MoviesIOS
//
//  Created by Rhulani Ndhlovu on 2021/01/07.
//

import Foundation

class MoviesAPIClient: MoviesAPIClientProtocol{
    var session: URLSession!
    var checkD: Any!
    
    public static let shared = MoviesAPIClient()
    init() {}
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        //.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .iso8601
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    
    // MARK:- Get All Movies api request
    public func getMovies(params: [String: String]? = nil, successHandler: @escaping (_ response: Movies) -> Void, errorHandler: @escaping(_ error: Error) -> Void) {
        
        session = URLSession.shared
        
        var urlBuilder = URLComponents(string: Constants.API_BASE_URL+Constants.MOVIES_ENDPOINT)
        urlBuilder?.queryItems = [
        ]
        
        guard let url = urlBuilder?.url else {
            errorHandler(MovieError.invalidEndpoint)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(Constants.API_AUTH_TOKEN, forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request) { [self] (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                errorHandler(MovieError.invalidResponse)
                return
            }
            
            
            guard error == nil else {
                errorHandler(MovieError.apiError)
                return
            }
            
            guard let data = data else {
                errorHandler(MovieError.noData)
                return
            }
            
            do {
                checkD = try JSONSerialization.jsonObject(with: data, options:.allowFragments)
                let movies = try self.jsonDecoder.decode(Movies.self, from: data)
                //print(movies)
                DispatchQueue.main.async {
                    
                    successHandler(movies)
                    //print(movies)
                }
            } catch {
                print(error)
                errorHandler(MovieError.serializationError)
            }
            
        }
        .resume()
    }
    
    
    // MARK:- Search Movies api request
    public func searchMovie(query: String, params: [String : String]?, successHandler: @escaping (Movies) -> Void, errorHandler: @escaping (Error) -> Void) {
        
        session = URLSession.shared
        
        var urlBuilder = URLComponents(string: Constants.API_BASE_URL+Constants.MOVIES_ENDPOINT)
        urlBuilder?.queryItems = [ URLQueryItem(name: "q", value: query)]
        
        guard let url = urlBuilder?.url else {
            errorHandler(MovieError.invalidEndpoint)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(Constants.API_AUTH_TOKEN, forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                self.handleError(errorHandler: errorHandler, error: MovieError.apiError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.handleError(errorHandler: errorHandler, error: MovieError.invalidResponse)
                return
            }
            
            guard let data = data else {
                self.handleError(errorHandler: errorHandler, error: MovieError.noData)
                return
            }
            
            do {
                let moviesResponse = try self.jsonDecoder.decode(Movies.self, from: data)
                DispatchQueue.main.async {
                    successHandler(moviesResponse)
                }
            } catch {
                self.handleError(errorHandler: errorHandler, error: MovieError.serializationError)
            }
            }.resume()
    }
    
    private func handleError(errorHandler: @escaping(_ error: Error) -> Void, error: Error) {
            DispatchQueue.main.async {
                errorHandler(error)
            }
        }
}
