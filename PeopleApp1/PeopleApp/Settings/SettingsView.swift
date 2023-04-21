//
//  SettingsView.swift
//  PeopleApp
//
//  Created by LuciaDecode on 20.12.2022..
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage(UserDefaultKeys.hapticsEnabled) private var isHapticsEnabled: Bool = true
    
    var body: some View {
        NavigationView {
            Form {
                Toggle("Enable Haptics", isOn: $isHapticsEnabled)
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
