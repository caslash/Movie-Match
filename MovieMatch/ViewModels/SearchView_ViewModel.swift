//
//  SearchView_ViewModel.swift
//  MovieMatch
//
//  Created by Cameron Slash on 14/2/22.
//

import Combine
import Foundation

extension SearchView {
    final class ViewModel: ObservableObject {
        fileprivate let API_KEY = PrivateData.API_KEY
        @Published var isLoading: Bool = false
        @Published var results: [SearchItem] = []
        
        var searchTerm: String = ""
        
        private let searchTappedSubject = PassthroughSubject<Void, Error>()
        private var disposeBag = Set<AnyCancellable>()
        
        init() {
            searchTappedSubject
                .flatMap {
                    self.requestItems(searchTerm: self.searchTerm)
                        .handleEvents(receiveSubscription: { _ in
                            DispatchQueue.main.async {
                                self.isLoading = true
                            }
                        }, receiveCompletion: { comp in
                            DispatchQueue.main.async {
                                self.isLoading = false
                            }
                        })
                        .eraseToAnyPublisher()
                }
                .replaceError(with: [])
                .receive(on: DispatchQueue.main)
                .assign(to: \.results, on: self)
                .store(in: &disposeBag)
        }
        
        func onSearchTapped() {
            searchTappedSubject.send()
        }
        
        private func requestItems(searchTerm: String) -> AnyPublisher<[SearchItem], Error> {
            guard let url = URL(string: "https://api.themoviedb.org/3/search/multi?api_key=\(self.API_KEY)&language=\(ModelData.shared.language.rawValue.lowercased())&query=\(searchTerm)&page=1&include_adult=false&region=\(ModelData.shared.region.rawValue)") else {
                return Fail(error: URLError(.badURL))
                    .mapError { $0 as Error }
                    .eraseToAnyPublisher()
            }
            
            print(url)
            
            return URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .mapError { $0 as Error }
                .decode(type: SearchResponse.self, decoder: JSONDecoder())
                .map { $0.results }
                .eraseToAnyPublisher()
        }
    }
}
