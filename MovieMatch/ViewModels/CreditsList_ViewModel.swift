//
//  CreditsList_ViewModel.swift
//  MovieMatch
//
//  Created by Cameron Slash on 10/4/22.
//

import Combine
import Foundation

extension CreditsListView {
    final class ViewModel: ObservableObject {
        fileprivate var API_KEY = PrivateData.API_KEY
        
        @Published var cast: [Actor]?
        @Published var crew: [CrewMate]?
        
        private var anycancellableset: Set<AnyCancellable>
        
        init(id: Int, mediaType: MediaType) {
            self.anycancellableset = Set<AnyCancellable>()
            getCast(id: id, mediaType: mediaType)
            getCrew(id: id, mediaType: mediaType)
        }
        
        func invalidate() {
            for cancellable in anycancellableset {
                cancellable.cancel()
            }
            print("[<<] invalidated")
        }
        
        deinit {
            print("[x] done")
        }
        
        func getCast(id: Int, mediaType: MediaType) {
            if let url = URL(string:  "https://api.themoviedb.org/3/\(mediaType.urlShortened)/\(id)/credits?api_key=\(self.API_KEY)&language=\(ModelData.shared.language.rawValue.lowercased())") {
                
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                
                URLSession.shared.dataTaskPublisher(for: request)
                    .tryMap { try ModelData.jsonDecoder.decode(Credits.self, from: $0.data).cast }
                    .receive(on: RunLoop.main)
                    .sink(receiveCompletion: { print("completion: \($0)") }, receiveValue: { if !$0.isEmpty{ self.cast = $0 } })
                    .store(in: &anycancellableset)
            }
        }
        
        func getCrew(id: Int, mediaType: MediaType) {
            if let url = URL(string:  "https://api.themoviedb.org/3/\(mediaType.urlShortened)/\(id)/credits?api_key=\(self.API_KEY)&language=\(ModelData.shared.language.rawValue.lowercased())") {
                
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                
                URLSession.shared.dataTaskPublisher(for: request)
                    .tryMap { try ModelData.jsonDecoder.decode(Credits.self, from: $0.data).crew }
                    .receive(on: RunLoop.main)
                    .sink(receiveCompletion: { print("completion: \($0)") }, receiveValue: { if !$0.isEmpty{ self.crew = $0 } })
                    .store(in: &anycancellableset)
            }
        }
    }
}
