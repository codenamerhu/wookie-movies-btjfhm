//
//  MovieViewViewModel.swift
//  MoviesIOS
//
//  Created by Rhulani Ndhlovu on 2021/01/07.
//

import Foundation


struct MovieViewViewModel {
    
    private var movie: Movie
    
    private static let dateFormatter: DateFormatter = {
        $0.dateStyle = .medium
        $0.timeStyle = .none
        return $0
    }(DateFormatter())
    
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var title: String {
        return movie.title
    }
    
    var poster: String {
        return movie.poster
    }
    
    var overview: String {
        return movie.overview
    }
    
    var genres: [String] {
        return movie.genres
    }
    
    var backdrop : String {
        return movie.backdrop
    }
    
    var director : [String] {
        return movie.director
    }
    
    var cast : [String] {
        return movie.cast
    }
    
    var length: String {
        return movie.length
    }
    
    var yeer: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from:movie.released_on)
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date!)
        
        return "\(String(describing: components.year!))"
    }
    
    var rating: Double {
        
        return movie.imdb_rating
    }
    
}
