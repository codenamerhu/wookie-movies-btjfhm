//
//  Constants.swift
//  MoviesIOS
//
//  Created by Rhulani Ndhlovu on 2021/01/05.
//

import Foundation

import Foundation

struct Constants {
    
    
    // MARK:- Networking related
    static let API_BASE_URL     = "https://wookie.codesubmit.io"
    static let MOVIES_ENDPOINT  = "/movies"
    static let SEARCH_QUERY     = "q"
    static let API_AUTH_TOKEN   = "Bearer Wookie2019"
    
    // MARK:- Movie genres
    static let ACTION       = "Action"
    static let CRIME        = "Crime"
    static let DRAMA        = "Drama"
    static let ANIMATION    = "Animation"
    static let FAMILY       = "Family"
    static let THRILLER     = "Thriller"
    static let BIOGRAPHY    = "Biography"
    static let HISTORY      = "History"
    static let ADVENTURE    = "Adventure"
    static let SCI_FI       = "Sci-Fi"
    static let ROMANCE      = "Romance"
    static let WAR          = "War"
    static let MYSTERY      = "Mystery"
    
    static let categories = [Constants.ACTION, Constants.ADVENTURE, Constants.ANIMATION, Constants.BIOGRAPHY, Constants.CRIME, Constants.DRAMA, Constants.FAMILY, Constants.HISTORY, Constants.MYSTERY, Constants.ROMANCE, Constants.SCI_FI, Constants.THRILLER]
    
}
