//
//  DetailView_ViewModel.swift
//  MovieMatch
//
//  Created by Cameron Slash on 08/4/22.
//

import Combine
import Foundation

extension DetailView {
    final class ViewModel: ObservableObject {
        fileprivate var API_KEY = PrivateData.API_KEY
        
        @Published var item: T? = nil
        
        private var anycancellableset: Set<AnyCancellable>
        
        init(id: Int) {
            print("[>>] created")
            
            self.anycancellableset = Set<AnyCancellable>()
            
            if T.self == Movie.self {
                getMovie(id)
            } else {
                getShow(id)
            }
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
        
        private func getMovie(_ id: Int) {
            if let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(self.API_KEY)&language=\(ModelData.shared.language.rawValue.lowercased())&append_to_response=releases") {
                
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                
                URLSession.shared.dataTaskPublisher(for: request)
                    .tryMap { try ModelData.jsonDecoder.decode(Movie.self, from: $0.data) }
                    .receive(on: RunLoop.main)
                    .sink(receiveCompletion: { print("completion: \($0)") }, receiveValue: { self.item = $0 as? T})
                    .store(in: &anycancellableset)
            }
        }
        
        private func getShow(_ id: Int) {
            if let url = URL(string:  "https://api.themoviedb.org/3/tv/\(id)?api_key=\(self.API_KEY)&language=\(ModelData.shared.language.rawValue.lowercased())&append_to_response=content_ratings") {
                
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                
                URLSession.shared.dataTaskPublisher(for: request)
                    .tryMap { try ModelData.jsonDecoder.decode(Show.self, from: $0.data) }
                    .receive(on: RunLoop.main)
                    .sink(receiveCompletion: { print("completion: \($0)") }, receiveValue: { self.item = $0 as? T })
                    .store(in: &anycancellableset)
            }
        }
    }
}
