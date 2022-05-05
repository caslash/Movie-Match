//
//  OverviewView.swift
//  MovieMatch
//
//  Created by Cameron Slash on 21/1/22.
//

import SwiftUI

struct OverviewView: View {
    let overview: String
    var body: some View {
        if overview != "" {
            VStack(alignment: .leading, spacing: 0) {
                Text("Overview")
                    .font(.largeTitle.weight(.black))
                
                Text(overview)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
            }
        }
    }
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewView(overview: PreviewMovies.blackPanther.wrappedOverview)
    }
}
