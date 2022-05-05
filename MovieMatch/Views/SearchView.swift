//
//  SearchView.swift
//  MovieMatch
//
//  Created by Cameron Slash on 14/2/22.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var modelData: ModelData
    @ObservedObject var viewModel = ViewModel()
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: true) {
                SearchBar(text: $viewModel.searchTerm, onSearchButtonClicked: viewModel.onSearchTapped)
                
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.results, id: \.id) { item  in
                        if item.mediaType == "movie" {
                            NavigationLink(destination: DetailView<Movie>(id: item.id)) {
                                PosterView(url: item.wrappedPosterPath)
                            }
                        } else if item.mediaType == "tv" {
                            NavigationLink(destination: DetailView<Show>(id: item.id)) {
                                PosterView(url: item.wrappedPosterPath)
                            }
                        }
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 5)
                }
            }
            .navigationTitle("Search")
            .navigationBarHidden(true)
        }
        .accentColor(modelData.accentColor)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(ModelData.shared)
    }
}
