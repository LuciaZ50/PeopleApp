//
//  PeopleAppApp.swift
//  PeopleApp
//
//  Created by LuciaDecode on 09.12.2022..
//

import SwiftUI

@main
struct PeopleApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                let service = Service()
                let vm = HomeViewModel(service: service)
                HomeView(viewModel: vm)
                    .tabItem {
                        VStack {
                            Image(systemName: "person")
                            Text("Home")
                        }
                    }
                    .toolbarBackground(.visible, for: .tabBar)
                SettingsView()
                    .tabItem {
                        VStack {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                    }
            }
            
        }
    }
}
