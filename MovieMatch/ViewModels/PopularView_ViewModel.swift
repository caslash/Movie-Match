//
//  PopularView_ViewModel.swift
//  MovieMatch
//
//  Created by Cameron Slash on 08/4/22.
//

import Combine
import Foundation

extension PopularView {
    final class ViewModel: ObservableObject {
        fileprivate let API_KEY = PrivateData.API_KEY
        @Published var isLoading: Bool = false
        
        @Published var popularMovies = [PopularMovie]()
        @Published var popularShows = [PopularShow]()
        
        private var anycancellableset: Set<AnyCancellable>
        
        init() {
            self.anycancellableset = Set<AnyCancellable>()
            getPopularMovies()
            getPopularShows()
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
        
        private func getPopularMovies() {
            if let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(self.API_KEY)&language=\(ModelData.shared.language.rawValue.lowercased())&page=1&region=\(ModelData.shared.region.rawValue)") {
                
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                
                URLSession.shared.dataTaskPublisher(for: request)
                    .tryMap { try ModelData.jsonDecoder.decode(PopularMovieResponse.self, from: $0.data) }
                    .receive(on: RunLoop.main)
                    .sink(receiveCompletion: { print("completion: \($0)") }, receiveValue: { self.popularMovies = $0.results })
                    .store(in: &anycancellableset)
            }
        }
        
        private func getPopularShows() {
            if let url = URL(string: "https://api.themoviedb.org/3/tv/popular?api_key=\(self.API_KEY)&language=\(ModelData.shared.language.rawValue.lowercased())&page=1&region=\(ModelData.shared.region.rawValue)") {
                
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                
                URLSession.shared.dataTaskPublisher(for: request)
                    .tryMap { try ModelData.jsonDecoder.decode(PopularShowResponse.self, from: $0.data) }
                    .receive(on: RunLoop.main)
                    .sink(receiveCompletion: { print("completion: \($0)") }, receiveValue: { self.popularShows = $0.results })
                    .store(in: &anycancellableset)
            }
        }
    }
}
