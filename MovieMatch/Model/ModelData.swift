//
//  ModelData.swift
//  MovieMatch
//
//  Created by Cameron Slash on 08/4/22.
//

import Foundation
import SwiftUI

class ModelData: ObservableObject {
    fileprivate let API_KEY = PrivateData.API_KEY
    
    static let shared = ModelData()
    
    @Published var region: Iso3166_1a2 = .us {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(region) {
                UserDefaults.standard.set(encoded, forKey: "region")
            }
        }
    }
    
    @Published var language: Iso639_1 = .en {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(language) {
                UserDefaults.standard.set(encoded, forKey: "language")
            }
        }
    }
    
    @Published var accentColor: Color = .init(hexString: "#ee250b") {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(accentColor) {
                UserDefaults.standard.set(encoded, forKey: "accent_color")
            }
        }
    }
    
    func resetSettings() {
        self.accentColor = .init(hexString: "#ee250b")
        self.language = .en
        self.region = .us
    }
    
    var buildNum: String {
        if let text = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            return text
        }
        return "0"
    }
    
    var versionNum: String {
        if let text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return text
        }
        return "0"
    }
    
    var settingsDefault: Bool {
        return accentColorDefault && regionDefault && languageDefault
    }
    
    var accentColorDefault: Bool {
        accentColor == .init(hexString: "#ee250b")
    }
    
    var regionDefault: Bool {
        region == .us
    }
    
    var languageDefault: Bool {
        language == .en
    }
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    static var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(self.dateFormatter)
        return decoder
    }
    
    init() {
        if let saved_region = UserDefaults.standard.data(forKey: "region") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode(Iso3166_1a2.self, from: saved_region) {
                self.region = decoded
            }
        }
        
        if let saved_language = UserDefaults.standard.data(forKey: "language") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode(Iso639_1.self, from: saved_language) {
                self.language = decoded
            }
        }
        
        if let saved_accent_color = UserDefaults.standard.data(forKey: "accent_color") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode(Color.self, from: saved_accent_color) {
                self.accentColor = decoded
            }
        }
    }
}
