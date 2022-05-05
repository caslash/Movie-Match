//
//  DetailView.swift
//  MovieMatch
//
//  Created by Cameron Slash on 08/4/22.
//

import SwiftUI

struct DetailView<T: MDBItem>: View {
    @EnvironmentObject var modelData: ModelData
    @ObservedObject private var viewModel: ViewModel
    @State private var id: Int
    private var mediaType: MediaType {
        if T.self is Movie.Type {
            return .movie
        } else {
            return .tv
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            if let backdropURL = viewModel.item?.wrappedBackdropPath {
                GeometryReader { geometry in
                    Backdrop(geometry: geometry, url: backdropURL)
                }
                .frame(height: 250)
            }
            
            LazyVStack(spacing: 10) {
                InfoCard(item: viewModel.item)
                
                OverviewView(overview: viewModel.item?.wrappedOverview ?? "")
                
                CreditsListView(id: id, mediaType: mediaType)
            }
            .padding(.horizontal)
            .offset(y: viewModel.item?.wrappedBackdropPath != nil ? -130 : 0)
        }
        .onDisappear {
            self.viewModel.invalidate()
        }
        .edgesIgnoringSafeArea(viewModel.item?.wrappedBackdropPath != nil ? .all : .horizontal)
    }
    
    init(id: Int) {
        self.viewModel = ViewModel(id: id)
        self.id = id
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView<Movie>(id: PreviewMovies.eternals.id)
            .environmentObject(ModelData.shared)
    }
}
