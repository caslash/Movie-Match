//
//  PersonCard.swift
//  MovieMatch
//
//  Created by Cameron Slash on 20/1/22.
//

import Nuke
import SwiftUI

struct PersonCard<T: Person>: View {
    @EnvironmentObject var modelData: ModelData
    @StateObject private var image = FetchImage()
    let person: T
    @ViewBuilder var body: some View {
        VStack(spacing: 5) {
            if person.hasProfilePic {
                image.view?
                    .resizable()
                    .scaledToFill()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .shadow(radius: 8, x: 0, y: 8)
            }
            
            Text(person.wrappedName)
                .font(.subheadline.weight(.black))
                .multilineTextAlignment(.center)
            
            if T.self is Actor.Type {
                let actor = person as! Actor
                
                Text(actor.wrappedCharacter)
                    .font(.footnote.weight(.light))
                    .foregroundColor(modelData.accentColor)
                    .multilineTextAlignment(.center)
            } else if T.self is CrewMate.Type {
                let crew = person as! CrewMate
                
                Text(crew.wrappedJob)
                    .font(.footnote.weight(.light))
                    .foregroundColor(modelData.accentColor)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(width: 150, height: 150)
        .onAppear { image.load(person.wrappedProfilePath) }
        .onChange(of: person.wrappedProfilePath) { image.load($0) }
        .onDisappear(perform: image.reset)
    }
}

struct CastCard_Previews: PreviewProvider {
    static var previews: some View {
        PersonCard(person: PreviewCrew.rickandmortycast.first!)
            .environmentObject(ModelData.shared)
    }
}
