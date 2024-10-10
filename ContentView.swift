//
//  ContentView.swift
//  ResumePortfolio
//
//  Created by Eric Cheyne on 10/9/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            ResumeView()
                .tabItem {
                    Label("Resume", systemImage: "doc.text")
                }
            PortfolioView()
                .tabItem {
                    Label("Portfolio", systemImage: "folder")
                }
            ContactView()
                .tabItem {
                    Label("Contact", systemImage: "envelope")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
