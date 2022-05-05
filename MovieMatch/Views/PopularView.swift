//
//  PopularView.swift
//  MovieMatch
//
//  Created by Cameron Slash on 08/4/22.
//

import SwiftUI

struct PopularView: View {
    @EnvironmentObject var modelData: ModelData
    @ObservedObject var viewModel = ViewModel()
    @State private var selectedType: MediaType = .tv
    @State private var showingSearch = false
    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
        NavigationView {
            ScrollView {
                Picker("Media Type Selection", selection: $selectedType) {
                    ForEach(MediaType.allCases, id: \.self) { type in
                        Text(type.displayName)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                list
            }
            .navigationTitle("Popular \(modelData.region.flag)")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingSearch = true }) {
                        Image(systemName: .magnifyingglass)
                    }
                }
            }
            .sheet(isPresented: $showingSearch, content: { SearchView() })
        }
        .accentColor(modelData.accentColor)
        .onDisappear {
            self.viewModel.invalidate()
        }
    }
    
    @ViewBuilder var list: some View {
        LazyVGrid(columns: columns) {
            switch selectedType {
            case .tv:
                ForEach(viewModel.popularShows, id: \.id) { show in
                    NavigationLink(destination: DetailView<Show>(id: show.id)) {
                        PosterView(url: show.wrappedPosterPath)
                    }
                }
                .padding(.vertical)
                .padding(.horizontal, 5)
            case .movie:
                ForEach(viewModel.popularMovies, id: \.id) { movie in
                    NavigationLink(destination: DetailView<Movie>(id: movie.id)) {
                        PosterView(url: movie.wrappedPosterPath)
                    }
                }
                .padding(.vertical)
                .padding(.horizontal, 5)
            }
        }
    }
}

struct PopularView_Previews: PreviewProvider {
    static var previews: some View {
        PopularView()
            .environmentObject(ModelData.shared)
    }
}
