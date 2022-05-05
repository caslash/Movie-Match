//
//  CastObjects.swift
//  MovieMatch
//
//  Created by Cameron Slash on 20/1/22.
//

import Foundation

protocol Person: Codable, Identifiable, Hashable {
    var gender: Int? { get }
    var id: Int { get }
    var name: String? { get }
    var profilePath: String? { get }
}

extension Person {
    var wrappedName: String { name ?? "Unknown Actor" }
    
    var wrappedProfilePath: URL {
        guard let profilePath = profilePath else {
            return URL(string: "https://via.placeholder.com/1000/09f/fff.png")!
        }
        
        return URL(string: "https://image.tmdb.org/t/p/original\(profilePath)")!
    }
    
    var hasProfilePic: Bool {
        if profilePath == nil {
            return false
        }
        return true
    }
}

struct Credits: Codable, Identifiable {
    var id: Int?
    var cast: [Actor]
    var crew: [CrewMate]
}

struct Actor: Person {
    enum CodingKeys: String, CodingKey {
        case gender, id, name, popularity, profilePath = "profile_path", character
    }
    
    var gender: Int?
    var id: Int
    var name: String?
    var popularity: Float?
    var profilePath: String?
    var character: String?
    
    var wrappedCharacter: String { character ?? "Unknown Character" }
}

struct CrewMate: Person {
    enum CodingKeys: String, CodingKey {
        case gender, id, name, department, job
    }
    
    var gender: Int?
    var id: Int
    var name: String?
    var department: String?
    var profilePath: String?
    var job: String?
    
    var wrappedJob: String { job ?? "Unknown Job" }
}

struct PreviewCrew {
    static let chadwick: Actor = {
        let url = Bundle.main.url(forResource: "BPCast-Crew", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let list = try! decoder.decode(Credits.self, from: data)
        return list.cast.first!
    }()
    
    static let blackpanthercast: [Actor] = {
        let url = Bundle.main.url(forResource: "BPCredits", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let list = try! decoder.decode(Credits.self, from: data)
        return list.cast
    }()
    
    static let rickandmortycast: [Actor] = {
        let url = Bundle.main.url(forResource: "RMCredits", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let list = try! decoder.decode(Credits.self, from: data)
        return list.cast
    }()
    
//    static let crew: [CrewMate?] = {
//        let url = Bundle.main.url(forResource: "BPCast-Crew", withExtension: ".json")!
//        let data = try! Data(contentsOf: url)
//        let decoder = JSONDecoder()
//        let list = try! decoder.decode(CastList.self, from: data)
//        guard let crewmates = list.crew else { return [] }
//        return crewmates
//    }()
}
