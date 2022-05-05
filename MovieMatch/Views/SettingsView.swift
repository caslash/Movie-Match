//
//  SettingsView.swift
//  MovieMatch
//
//  Created by Cameron Slash on 25/1/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var modelData: ModelData
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section(header: Text("Preferences")) {
                        ColorPicker("Accent Color", selection: $modelData.accentColor)
                    }
                    
                    Section(header: Text("Location")) {
                        Picker("Country/Region", selection: $modelData.region) {
                            ForEach(Iso3166_1a2.allCases, id: \.self) { region in
                                Text(region.country)
                            }
                        }
                        
                        Picker("Language", selection: $modelData.language) {
                            ForEach(Iso639_1.allCases, id: \.self) { langauge in
                                Text(langauge.language)
                            }
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    
                    Text("v\(modelData.versionNum) build \(modelData.buildNum)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom)
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Reset") {
                        modelData.resetSettings()
                    }
                    .disabled(modelData.settingsDefault)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ModelData.shared)
    }
}
