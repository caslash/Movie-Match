//
//  SearchObject.swift
//  MovieMatch
//
//  Created by Cameron Slash on 14/2/22.
//

import Foundation

struct SearchResponse: Codable {
    var results: [SearchItem]
}

struct SearchItem: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id, mediaType = "media_type", posterPath = "poster_path"
    }
    
    var id: Int
    var mediaType: String
    var posterPath: String?
    
    var wrappedPosterPath: URL {
        guard let posterPath = posterPath else {
            return URL(string: "https://via.placeholder.com/1000/09f/fff.png")!
        }

        return URL(string: "https://image.tmdb.org/t/p/original\(posterPath)")!
    }
}
