//
//  InfoCard.swift
//  MovieMatch
//
//  Created by Cameron Slash on 09/4/22.
//

import SwiftUI
import Nuke

struct InfoCard<T:MDBItem>: View {
    @EnvironmentObject var modelData: ModelData
    var item: T?
    var body: some View {
        ZStack {
            HStack {
                PosterView(url: item?.wrappedPosterPath)
                
                Spacer()
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    PrimaryInfo(item)
                    
                    Spacer()
                }
            }
        }
        .padding()
        .padding(.leading, 5)
        .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width/2 + 10)
        .background(.ultraThinMaterial)
        .cornerRadius(25)
        .shadow(radius: 8, x: 0, y: 8)
    }
}

struct InfoCard_Previews: PreviewProvider {
    static var previews: some View {
        InfoCard(item: PreviewMovies.blackPanther)
            .environmentObject(ModelData.shared)
    }
}
