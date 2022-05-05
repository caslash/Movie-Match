//
//  MDBItem.swift
//  MovieMatch
//
//  Created by Cameron Slash on 07/2/22.
//

import Foundation
import UIKit

protocol MDBItem: Codable, Equatable, Identifiable {
    var adult: Bool { get }
    var backdropPath: String? { get }
    var genres: [Genre]? { get }
    var homepage: String? { get }
    var id: Int { get }
    var releaseDate: Date? { get }
    var originalLanguage: Iso639_1 { get }
    var overview: String? { get }
    var popularity: Float? { get }
    var posterPath: String? { get }
    var productionCompanies: [ProductionCompany]? { get }
    var productionCountries: [ProductionCountry]? { get }
    var spokenLanguages: [SpokenLanguage]? { get }
    var status: String? { get }
    var tagline: String? { get }
    var title: String? { get }
}

extension MDBItem {
    var wrappedBackdropPath: URL? {
        guard let backdropPath = backdropPath else {
            return nil
        }

        return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath)")!
    }

    var wrappedHomepage: URL? {
        if !homepage!.isEmpty {
            return URL(string: homepage!)
        }
        return nil
    }
    
    var wrappedReleaseDate: Date {
        releaseDate ?? Date.now
    }

    var wrappedOverview: String {
        overview ?? ""
    }

    var wrappedPosterPath: URL {
        guard let posterPath = posterPath else {
            return URL(string: "https://via.placeholder.com/1000/09f/fff.png")!
        }

        return URL(string: "https://image.tmdb.org/t/p/original\(posterPath)")!
    }

    var wrappedTagline: String {
        tagline ?? ""
    }
    
    var wrappedTitle: String {
        title ?? "Title Unavailable"
    }
    
//    var saved: Bool {
//        ModelData.shared.savedItems.contains(id)
//    }
}
