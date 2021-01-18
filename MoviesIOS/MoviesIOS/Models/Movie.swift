//
//  Movie.swift
//  MoviesIOS
//
//  Created by Rhulani Ndhlovu on 2021/01/07.
//

import Foundation
import AnyCodable

public struct Movies : Codable {
    public let movies: [Movie]
    
    
    enum CodingKeys: String, CodingKey {
        case movies = "movies"
    }
}

public struct Movie: Codable {
    public var backdrop        : String
    public var cast            : [ String ]
    public var classification  : String
    public var director        : [String]
    public var genres          : [ String ]
    public var id              : String
    public var imdb_rating     : Double
    public var length          : String
    public var overview        : String
    public var poster          : String
    public var released_on     : String
    public var slug            : String
    public let title           : String
    
    public init(from decoder: Decoder) throws {
            // First pull out the "products" key
            let container = try decoder.container(keyedBy: CodingKeys.self)

            do {
                // Then try to decode the value as an array
                backdrop = try container.decode(String.self, forKey: .backdrop)
                cast = try container.decode([String].self, forKey: .cast)
                classification = try container.decode(String.self, forKey: .classification)
                director = try container.decode([String].self, forKey: .director)
                genres = try container.decode([String].self, forKey: .genres)
                id = try container.decode(String.self, forKey: .id)
                imdb_rating = try container.decode(Double.self, forKey: .imdb_rating)
                length = try container.decode(String.self, forKey: .length)
                overview = try container.decode(String.self, forKey: .overview)
                poster = try container.decode(String.self, forKey: .poster)
                released_on = try container.decode(String.self, forKey: .released_on)
                slug = try container.decode(String.self, forKey: .slug)
                title = try container.decode(String.self, forKey: .title)
            } catch {
                // If that didn't work, try to decode it as a single value
                backdrop = try container.decode(String.self, forKey: .backdrop)
                cast = try container.decode([String].self, forKey: .cast)
                classification = try container.decode(String.self, forKey: .classification)
                director = [try container.decode(String.self, forKey: .director)]
                genres = try container.decode([String].self, forKey: .genres)
                id = try container.decode(String.self, forKey: .id)
                imdb_rating = try container.decode(Double.self, forKey: .imdb_rating)
                length = try container.decode(String.self, forKey: .length)
                overview = try container.decode(String.self, forKey: .overview)
                poster = try container.decode(String.self, forKey: .poster)
                released_on = try container.decode(String.self, forKey: .released_on)
                slug = try container.decode(String.self, forKey: .slug)
                title = try container.decode(String.self, forKey: .title)
            }
        }
    
}

public struct Director:  Codable {
    public let director: [String]
    
    enum CodingKeys: String, CodingKey {
        case director = "director"
    }
    
    public init(from decoder: Decoder) throws {
            // First pull out the "products" key
            let container = try decoder.container(keyedBy: CodingKeys.self)

            do {
                // Then try to decode the value as an array
                director = try container.decode([String].self, forKey: .director)
            } catch {
                // If that didn't work, try to decode it as a single value
                director = [try container.decode(String.self, forKey: .director)]
            }
        }
    
}



// MARK: - TaskID
struct TaskID: Codable {
    let embedded: Embedded
    let count: Int

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
        case count
    }
}

// MARK: - Embedded
struct Embedded: Codable {
    let task: [Task]
}

// MARK: - Task
struct Task: Codable {
    let embedded: EmbeddedVariable
    let id, name, assignee, created: String
    let processDefinitionID: String

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
        case id, name, assignee, created
        case processDefinitionID = "processDefinitionId"
    }
}

// MARK: - EmbeddedVariable
struct EmbeddedVariable: Codable {
    let variable: [Variable]
}

// MARK: - Variable
struct Variable: Codable {
    let links: Links
    let name, value, type: String
    let valueInfo: ValueInfo

    enum CodingKeys: String, CodingKey {
        case links = "_links"
        case name, value, type, valueInfo
    }
}

// MARK: - Links
struct Links: Codable {
    let linksSelf: SelfClass

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - SelfClass
struct SelfClass: Codable {
    let href: String
}

// MARK: - ValueInfo
struct ValueInfo: Codable {
}
