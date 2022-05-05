//
//  MovieObjects.swift
//  MovieMatch
//
//  Created by Cameron Slash on 18/1/22.
//

import Foundation
import UIKit

struct Movie: MDBItem {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    
    enum CodingKeys: String, CodingKey {
        case adult, backdropPath = "backdrop_path", belongsToCollection = "belongs_to_collection", budget, genres, homepage, id, imdbID = "imdb_id", originalLanguage = "original_language", originalTitle = "original_title", overview, popularity, posterPath = "poster_path", productionCompanies = "production_companies", productionCountries = "production_countries", releaseDate = "release_date", revenue, runtime, spokenLanguages = "spoken_languages", status, tagline, title, video, voteAverage = "vote_average", voteCount = "vote_count", releases
    }
    
    var adult: Bool
    var backdropPath: String?
    var belongsToCollection: Collection?
    var budget: Int?
    var genres: [Genre]?
    var homepage: String?
    var id: Int
    var imdbID: String?
    var originalLanguage: Iso639_1
    var originalTitle: String?
    var overview: String?
    var popularity: Float?
    var posterPath: String?
    var productionCompanies: [ProductionCompany]?
    var productionCountries: [ProductionCountry]?
    var releaseDate: Date?
    var revenue: Int?
    var runtime: Int?
    var spokenLanguages: [SpokenLanguage]?
    var status: String?
    var tagline: String?
    var title: String?
    var video: Bool
    var voteAverage: Double?
    var voteCount: Int?
    var releases: Releases?
}

struct RecResponse: Codable {
    var results: [Recommendation]
}

struct Recommendation: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id, posterPath = "poster_path"
    }
    
    var id: Int
    var posterPath: String?
    
    var wrappedPosterPath: URL {
        guard let posterPath = posterPath else {
            return URL(string: "https://via.placeholder.com/1000/09f/fff.png")!
        }

        return URL(string: "https://image.tmdb.org/t/p/original\(posterPath)")!
    }
}

struct PopularMovieResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case page, results, totalPages = "total_pages", totalResults = "total_results"
    }
    
    static var emptyList = PopularMovieResponse(page: 0, results: [], totalPages: 0, totalResults: 0)
    
    var page: Int
    var results: [PopularMovie]
    var totalPages: Int
    var totalResults: Int
}

struct PopularMovie: Codable, Equatable, Identifiable {
    static func == (lhs: PopularMovie, rhs: PopularMovie) -> Bool {
        lhs.id == rhs.id
    }
    
    enum CodingKeys: String, CodingKey {
        case title, id, backdropPath = "backdrop_path", genreIDs = "genre_ids", posterPath = "poster_path", releaseDate = "release_date"
    }
    
    var title: String
    var id: Int
    var backdropPath: String?
    var genreIDs: [Int]
    var posterPath: String?
    var releaseDate: Date?
    
    var wrappedPosterPath: URL {
        guard let posterPath = posterPath else {
            return URL(string: "https://via.placeholder.com/1000/09f/fff.png")!
        }
        
        return URL(string: "https://image.tmdb.org/t/p/original\(posterPath)")!
    }
}

struct Collection: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id, name, posterPath = "poster_path", backdropPath = "backdrop_path"
    }
    
    var id: Int?
    var name: String?
    var posterPath: String?
    var backdropPath: String?
}

struct Genre: Codable, Comparable, Identifiable {
    static func < (lhs: Genre, rhs: Genre) -> Bool {
        lhs.wrappedName < rhs.wrappedName
    }
    
    var id: Int?
    var name: String?
    
    var wrappedName: String {
        guard let name = name else {
            return ""
        }
        return name
    }
}

struct ProductionCompany: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id, logoPath = "logo_path", name, originCountry = "origin_country"
    }
    
    var id: Int?
    var logoPath: String?
    var name: String?
    var originCountry: String?
}

struct ProductionCountry: Codable {
    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1", name
    }
    
    var iso31661: Iso3166_1a2?
    var name: String?
}

struct SpokenLanguage: Codable {
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name", iso6391 = "iso_639_1", name
    }
    
    var englishName: String?
    var iso6391: Iso639_1?
    var name: String?
}

struct Releases: Codable {
    var countries: [Country]
}

struct Country: Codable {
    enum CodingKeys: String, CodingKey {
        case certification, iso31661 = "iso_3166_1", primary, releaseDate = "release_date"
    }
    
    var certification: String?
    var iso31661: Iso3166_1a2
    var primary: Bool
    var releaseDate: Date
}

struct PreviewMovies {
    static let formatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let blackPanther: Movie = {
        let url = Bundle.main.url(forResource: "BlackPanther", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        return try! decoder.decode(Movie.self, from: data)
    }()
    
    static let eternals: Movie = {
        let url = Bundle.main.url(forResource: "Eternals", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        return try! decoder.decode(Movie.self, from: data)
    }()
    
    static let popularMovies: [PopularMovie] = {
        let url = Bundle.main.url(forResource: "PopularMovies", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        let list = try! decoder.decode(PopularMovieResponse.self, from: data)
        return list.results
    }()
}
