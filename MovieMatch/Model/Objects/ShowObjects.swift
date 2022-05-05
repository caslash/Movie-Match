//
//  ShowObjects.swift
//  MovieMatch
//
//  Created by Cameron Slash on 01/2/22.
//

import Foundation
import UIKit

struct Show: MDBItem {
    static func == (lhs: Show, rhs: Show) -> Bool {
        lhs.id == rhs.id
    }
    
    enum CodingKeys: String, CodingKey {
        case adult, backdropPath="backdrop_path", creators="created_by", contentRatings="content_ratings", episodeRunTime="episode_run_time", releaseDate="first_air_date", genres, homepage, id, inProduction="in_production", languages, lastAirDate="last_air_date", lastEpisodeToAir="last_episode_to_air", nextEpisodeToAir="next_episode_to_air", networks, numberOfEpisodes="number_of_episodes", numberOfSeasons="number_of_seasons", originCountry="origin_country", originalLanguage="original_language", originalName="original_name", overview, popularity, posterPath="poster_path", productionCompanies="production_companies", productionCountries="production_countries", seasons, spokenLanguages="spoken_languages", status, tagline, title = "name", type
    }
    
    var adult: Bool
    var backdropPath: String?
    var creators: [Creators]?
    var contentRatings: ContentRatings?
    var episodeRunTime: [Int]?
    var releaseDate: Date?
    var genres: [Genre]?
    var homepage: String?
    var id: Int
    var inProduction: Bool
    var languages: [Iso639_1]?
    var lastAirDate: Date?
    var lastEpisodeToAir: Episode?
    var title: String?
    var nextEpisodeToAir: Episode?
    var networks: [Network]?
    var numberOfEpisodes: Int?
    var numberOfSeasons: Int?
    var originCountry: [Iso3166_1a2]?
    var originalLanguage: Iso639_1
    var originalName: String?
    var overview: String?
    var popularity: Float?
    var posterPath: String?
    var productionCompanies: [ProductionCompany]?
    var productionCountries: [ProductionCountry]?
    var seasons: [Season]?
    var spokenLanguages: [SpokenLanguage]?
    var status: String?
    var tagline: String?
    var type: String
}

struct PopularShowResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case page, results, totalPages="total_pages", totalResults="total_results"
    }
    
    var page: Int
    var results: [PopularShow]
    var totalPages: Int
    var totalResults: Int
}

struct PopularShow: Codable, Equatable, Identifiable {
    static func == (lhs: PopularShow, rhs: PopularShow) -> Bool {
        lhs.id == rhs.id
    }
    
    enum CodingKeys: String, CodingKey {
        case backdropPath="backdrop_path", firstAirDate="first_air_date", genreIds="genre_ids", id, name, originCountry="origin_country", originalLanguage="original_language", originalName="original_name", overview, popularity, posterPath="poster_path"
    }
    
    var backdropPath: String?
    var firstAirDate: Date?
    var genreIds: [Int]?
    var id: Int
    var name: String?
    var originCountry: [Iso3166_1a2]?
    var originalLanguage: Iso639_1?
    var originalName: String?
    var overview: String?
    var popularity: Float?
    var posterPath: String?
    
    var wrappedPosterPath: URL {
        guard let posterPath = posterPath else {
            return URL(string: "https://via.placeholder.com/1000/09f/fff.png")!
        }
        
        return URL(string: "https://image.tmdb.org/t/p/original\(posterPath)")!
    }
}

struct Creators: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id, creditId="credit_id", name, profilePath="profile_path"
    }
    
    var id: Int?
    var creditId: String?
    var name: String?
    var profilePath: String?
}

struct Episode: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case airDate="air_date", episodeNumber="episode_number", name, id, overview, seasonNumber="season_number", stillPath="still_path"
    }
    
    var airDate: Date?
    var episodeNumber: Int?
    var id: Int
    var name: String?
    var overview: String?
    var seasonNumber: Int?
    var stillPath: String?
}

struct Season: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case airDate="air_date", episodeCount="episode_count", id, name, overview, posterPath="poster_path", seasonNumber="season_number"
    }
    
    var airDate: Date?
    var episodeCount: Int?
    var id: Int
    var name: String?
    var overview: String?
    var posterPath: String?
    var seasonNumber: Int?
}

struct Network: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case name, id, logoPath="logo_path", originCountry="origin_country"
    }
    
    var name: String?
    var id: Int?
    var logoPath: String?
    var originCountry: Iso3166_1a2
    
    var wrappedLogoPath: URL {
        guard let logoPath = logoPath else {
            return URL(string: "https://via.placeholder.com/1000/09f/fff.png")!
        }
        
        return URL(string: "https://image.tmdb.org/t/p/original\(logoPath)")!
    }
}

struct ContentRatings: Codable {
    var results: [Rating]
}
        
struct Rating: Codable {
    enum CodingKeys: String, CodingKey {
        case iso31661="iso_3166_1", rating
    }
    
    var iso31661: Iso3166_1a2
    var rating: String
}

struct PreviewShows {
    static let formatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let rickAndMorty: Show = {
        let url = Bundle.main.url(forResource: "Rick&Morty", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        return try! decoder.decode(Show.self, from: data)
    }()
    
    static let popularShows: [PopularShow] = {
        let url = Bundle.main.url(forResource: "PopularShows", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        let list = try! decoder.decode(PopularShowResponse.self, from: data)
        return list.results
    }()
}
