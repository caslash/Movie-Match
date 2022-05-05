//
//  PosterView.swift
//  MovieMatch
//
//  Created by Cameron Slash on 18/1/22.
//

import Nuke
import SwiftUI

struct PosterView: View {
    let url: URL?
    @StateObject private var image = FetchImage()
    var body: some View {
        ZStack {
            image.view?
                .resizable()
                .scaledToFit()
                .frame(height: UIScreen.main.bounds.width/2 - 30)
                .cornerRadius(15)
                .shadow(radius: 8, x: 0, y: 0)
        }
        .onAppear { image.load(url) }
        .onChange(of: url) { image.load($0) }
        .onDisappear(perform: image.reset)
    }
}

struct PosterView_Previews: PreviewProvider {
    static var previews: some View {
        PosterView(url: PreviewMovies.eternals.wrappedPosterPath)
    }
}
