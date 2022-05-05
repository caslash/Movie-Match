//
//  CreditsListView.swift
//  MovieMatch
//
//  Created by Cameron Slash on 10/4/22.
//

import SwiftUI

struct CreditsListView: View {
    @EnvironmentObject var modelData: ModelData
    @ObservedObject private var viewModel: ViewModel
    var body: some View {
        VStack {
            if let cast = viewModel.cast {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Cast")
                        .font(.largeTitle.weight(.black))
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(cast, id: \.self) { member in
                                PersonCard(person: member)
                            }
                        }
                    }
                }
            }
            
            if let crew = viewModel.crew {
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Crew")
                            .font(.largeTitle.weight(.black))
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(crew, id: \.self) { member in
                                    PersonCard(person: member)
                                }
                            }
                        }
                    }
                }
            }
        }
        .onDisappear {
            
        }
    }
    
    init(id: Int, mediaType: MediaType) {
        self.viewModel = ViewModel(id: id, mediaType: mediaType)
    }
}

struct CreditsListView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsListView(id: PreviewMovies.blackPanther.id, mediaType: .movie)
            .environmentObject(ModelData.shared)
    }
}
