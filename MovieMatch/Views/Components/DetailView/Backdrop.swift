//
//  Backdrop.swift
//  MovieMatch
//
//  Created by Cameron Slash on 07/2/22.
//

import Nuke
import SwiftUI

struct Backdrop: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var image = FetchImage()
    let geometry: GeometryProxy
    let url: URL?
    @ViewBuilder var body: some View {
        VStack {
            if geometry.frame(in: .global).minY <= 0 {
                image.view?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(y: geometry.frame(in: .global).minY/9)
                    .clipped()
            } else {
                image.view?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                    .clipped()
                    .offset(y: -geometry.frame(in: .global).minY)
            }
        }
        .onAppear { image.load(url) }
        .onChange(of: url) { image.load($0) }
        .onDisappear(perform: image.reset)
    }
}
