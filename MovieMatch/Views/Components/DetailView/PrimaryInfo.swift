//
//  PrimaryInfo.swift
//  MovieMatch
//
//  Created by Cameron Slash on 09/4/22.
//

import SwiftUI

struct PrimaryInfo<T: MDBItem>: View {
    @EnvironmentObject var modelData: ModelData
    @State var title: String
    @State var releaseYear: String
    @State var contentRating: String
    @State var tagline: String
    @State var genres: [Genre]?
    var body: some View {
        VStack(spacing: 5) {
            Text(title)
                .font(.title.weight(.heavy))
                .multilineTextAlignment(.center)
            
            if tagline != "" {
                Text(tagline)
                    .font(.caption)
                    .multilineTextAlignment(.center)
            }
            
            HStack {
                Text(releaseYear)
                
                Text(contentRating)
                    .font(.caption)
                    .padding(3)
                    .overlay {
                        RoundedRectangle(cornerRadius: 2)
                            .stroke()
                    }
                    .foregroundColor(modelData.accentColorDefault ? .secondary : modelData.accentColor)
            }
            
            if let genres = genres {
                GenreList(genres: genres)
            }
        }
    }
    
    init(_ item: T?) {
        if let item = item {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            
            if T.self is Movie.Type {
                let movie = item as! Movie
                guard let selectedRelease: [Country] = movie.releases?.countries.filter({ $0.iso31661 == ModelData.shared.region }) else {
                    self.title = ""
                    self.releaseYear = ""
                    self.contentRating = ""
                    self.tagline = ""
                    self.genres = [Genre]()
                    return
                }
                
                self.contentRating = selectedRelease.first(where: { $0.certification != "" })?.certification! ?? "Not Yet Rated"
            } else {
                let show = item as! Show
                guard let selectedRating: Rating = show.contentRatings?.results.first(where: { $0.iso31661 == ModelData.shared.region }) else {
                    self.title = ""
                    self.releaseYear = ""
                    self.contentRating = ""
                    self.tagline = ""
                    self.genres = [Genre]()
                    return
                }
                
                self.contentRating = selectedRating.rating
            }
            
            self.title = item.wrappedTitle
            self.releaseYear = dateFormatter.string(from: item.wrappedReleaseDate)
            self.tagline = item.wrappedTagline
            self.genres = item.genres
        } else {
            self.title = ""
            self.releaseYear = ""
            self.contentRating = ""
            self.tagline = ""
            self.genres = [Genre]()
        }
    }
}

struct PrimaryInfo_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryInfo<Movie>(PreviewMovies.blackPanther)
            .environmentObject(ModelData.shared)
    }
}
