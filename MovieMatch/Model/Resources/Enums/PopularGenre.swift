//
//  PopularGenre.swift
//  MovieMatch
//
//  Created by Cameron Slash on 21/1/22.
//

import Foundation

enum PopularGenre: String, CaseIterable, Codable {
    case all = "All"
    case action = "Action"
    case adventure = "Adventure"
    case animation = "Animation"
    case comedy = "Comedy"
    case crime = "Crime"
    case documentary = "Documentary"
    case drama = "Drama"
    case family = "Family"
    case fantasy = "Fantasy"
    case history = "History"
    case horror = "Horror"
    case music = "Music"
    case mystery = "Mystery"
    case romance = "Romance"
    case scienceFiction = "Science Fiction"
    case tvMovie = "TV Movie"
    case thriller = "Thriller"
    case war = "War"
    case western = "Western"
}

extension PopularGenre {
    public var id: Int {
        switch self {
        case .all:
            return 0
        case .action:
            return 28
        case .adventure:
            return 12
        case .animation:
            return 16
        case .comedy:
            return 35
        case .crime:
            return 80
        case .documentary:
            return 99
        case .drama:
            return 18
        case .family:
            return 10751
        case .fantasy:
            return 14
        case .history:
            return 36
        case .horror:
            return 27
        case .music:
            return 10402
        case .mystery:
            return 9648
        case .romance:
            return 10749
        case .scienceFiction:
            return 878
        case .tvMovie:
            return 10770
        case .thriller:
            return 53
        case .war:
            return 1075
        case .western:
            return 37
        }
    }
}
