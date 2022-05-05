//
//  GenreList.swift
//  MovieMatch
//
//  Created by Cameron Slash on 10/2/22.
//

import SwiftUI

struct GenreList: View {
    @EnvironmentObject var modelData: ModelData
    var genres: [Genre]
    var body: some View {
        if genres.count > 2 {
            VStack {
                HStack {
                    GenreTag(genre: genres[0])
                    GenreTag(genre: genres[1])
                }

                GenreTag(genre: genres[2])
            }
        } else {
            HStack {
                ForEach(genres, id: \.id) { genre in
                    GenreTag(genre: genre)
                }
            }
        }
    }
}

struct GenreListView_Previews: PreviewProvider {
    static var previews: some View {
        GenreList(genres: PreviewShows.rickAndMorty.genres!)
            .environmentObject(ModelData.shared)
            .previewLayout(.sizeThatFits)
    }
}

