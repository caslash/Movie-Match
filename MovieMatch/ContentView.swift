//
//  ContentView.swift
//  MovieMatch
//
//  Created by Cameron Slash on 08/4/22.
//

import SFSymbolsFinder
import SwiftUI

struct ContentView: View {
    enum Tab {
        case find, popular, settings, watchlist
    }
    @EnvironmentObject var modelData: ModelData
    @State private var selectedTab: Tab = .popular
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Find")
                .tabItem {
                    Image(systemName: .squareStack)
                    Text("Find")
                }
                .tag(Tab.find)
            
            PopularView()
                .tabItem {
                    Image(systemName: .listBulletCircle)
                    Text("Popular")
                }
                .tag(Tab.popular)
            
            Text("WatchList")
                .tabItem {
                    Image(systemName: .eyeCircle)
                    Text("WatchList")
                }
                .tag(Tab.watchlist)
            
            SettingsView()
                .tabItem {
                    Image(systemName: .gear)
                    Text("Settings")
                }
                .tag(Tab.settings)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData.shared)
    }
}
