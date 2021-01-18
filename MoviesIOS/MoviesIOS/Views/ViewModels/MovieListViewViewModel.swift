//
//  MovieListViewModel.swift
//  MoviesIOS
//
//  Created by Rhulani Ndhlovu on 2021/01/07.
//

import Foundation

import Foundation
import RxSwift
import RxCocoa

class MovieListViewViewModel {
    
    private let moviesApiClient: MoviesAPIClient
    private let disposeBag = DisposeBag()
    
    init(moviesApiClient: MoviesAPIClient) {
        self.moviesApiClient = moviesApiClient
        self.getMovies()
    }
    
    private let _movies = BehaviorRelay<[Movie]>(value: [])
    private var moves = [Movie]()
    
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private let _error = BehaviorRelay<String?>(value: nil)
    
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
    }
    
    var movies: Driver<[Movie]> {
        return _movies.asDriver()
    }
    
    var error: Driver<String?> {
        return _error.asDriver()
    }
    
    var hasError: Bool {
        return _error.value != nil
    }
    
    // MARK:- use to get all number of movies
    var numberOfMovies: Int {
        
        return _movies.value.count
    }
    
    // MARK:- use to get number of movies in genre
    func varNumberOfMoviesInGenre(genreIs: String) -> Int {
        var i = 0
        var count = 0
        while i < _movies.value.count {
            for genre in _movies.value[i].genres {
                
                if genre == genreIs {
                    //print("count is \(count)")
                    count += 1
                }
            }
            
            print(i)
            i += 1
        }
        
        return count
    }
    
    // MARK: Get Movie
    func viewModelForMovie(at index: Int) -> MovieViewViewModel? {
        guard index < _movies.value.count else {
            return nil
        }
        
        for movie in _movies.value {
            
            for genre in movie.genres {
                
                
                if genre == "Action" {
                    //debugPrint("movie is \(movie.title) = \(genre)")
                    moves.append(movie)
                    
                }
            }
            
        }
        
        return MovieViewViewModel(movie: _movies.value[index])
    }
    
    // MARK: Get Movie within specific genre
    func viewModelForMovieByGenre(at index: Int, for genreIs: String) -> MovieViewViewModel? {
        guard index < _movies.value.count else {
            return nil
        }
        
        for movie in _movies.value {
            
            for genre in movie.genres {
                
                
                if genre == genreIs {
                    moves.append(movie)
                    
                    
                }
            }
            
        }
        
        
        return MovieViewViewModel(movie: moves[index])
    }
    
    private func getMovies() {
        self._movies.accept([])
        self._isFetching.accept(true)
        self._error.accept(nil)
        
        moviesApiClient.getMovies(params: nil, successHandler: {[weak self] (response) in
            self?._isFetching.accept(false)
            self?._movies.accept(response.movies)
            
        }) { [weak self] (error) in
            self?._isFetching.accept(false)
            self?._error.accept(error.localizedDescription)
        }
    }
    
}

