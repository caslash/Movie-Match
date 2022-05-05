//
//  ProviderObjects.swift
//  MovieMatch
//
//  Created by Cameron Slash on 08/2/22.
//

import Foundation

struct ProviderResponse: Codable, Identifiable {
    var id: Int
    var results: ProviderResults
}

struct ProviderResults: Codable {
    var US: ProviderCountry
}

struct ProviderCountry: Codable {
    var link: URL?
    var rent: [Provider]?
    var free: [Provider]?
    var buy: [Provider]?
    var flatrate: [Provider]?
}

struct Provider: Codable, Comparable, Identifiable {
    static func < (lhs: Provider, rhs: Provider) -> Bool {
        lhs.displayPriority < rhs.displayPriority
    }
    
    enum CodingKeys: String, CodingKey {
        case displayPriority = "display_priority", logoPath = "logo_path", id = "provider_id", name = "provider_name"
    }
    
    var displayPriority: Int
    var logoPath: String?
    var id: Int
    var name: String
    
    var hasLogo: Bool {
        if logoPath == nil {
            return false
        }
        return true
    }
    
    var wrappedLogoPath: URL {
        guard let logoPath = logoPath else {
            return URL(string: "https://via.placeholder.com/1000/09f/fff.png")!
        }

        return URL(string: "https://image.tmdb.org/t/p/original\(logoPath)")!
    }
}

struct PreviewProviders {
    static let disneyplus: Provider = {
        return Provider(displayPriority: 1, logoPath: "/7rwgEs15tFwyR9NPQ5vpzxTj19Q.jpg", id: 337, name: "Disney Plus")
    }()
}
