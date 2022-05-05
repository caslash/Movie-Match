//
//  MediaType.swift
//  MovieMatch
//
//  Created by Cameron Slash on 27/1/22.
//

import Foundation

enum MediaType: Int32, CaseIterable {
    case tv = 0, movie = 1
}

extension MediaType {
    public var urlShortened: String {
        switch self {
        case .tv:
            return "tv"
        case .movie:
            return "movie"
        }
    }
    
    public var displayName: String {
        switch self {
        case .tv:
            return "TV Shows"
        case .movie:
            return "Movies"
        }
    }
    
//    public var type: Any {
//        switch self {
//        case .tv:
//            return Show.self
//        case .movie:
//            return Movie.self
//        }
//    }
    
    public var errorName: String {
        switch self {
        case .tv:
            return "TV Show"
        case .movie:
            return "Movie"
        }
    }
}
