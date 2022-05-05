//
//  GenreTag.swift
//  MovieMatch
//
//  Created by Cameron Slash on 10/2/22.
//

import SwiftUI

struct GenreTag: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.colorScheme) var colorScheme
    var genre: Genre
    var body: some View {
        Text(genre.wrappedName)
            .font(.caption2.weight(.heavy))
            .foregroundColor(colorScheme == .dark ? .black : .white)
            .frame(minWidth: 45, idealWidth: 45, minHeight: 15, idealHeight: 15)
            .padding(.horizontal)
            .background(modelData.accentColor)
            .clipShape(Capsule())
    }
}

struct GenreView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(PreviewShows.rickAndMorty.genres!) { genre in
            GenreTag(genre: genre)
                .previewDisplayName(genre.wrappedName)
                .previewLayout(.sizeThatFits)
                .padding(10)
        }
        .environmentObject(ModelData.shared)
    }
}
