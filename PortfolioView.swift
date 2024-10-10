//
//  PortfolioView.swift
//  ResumePortfolio
//
//  Created by Eric Cheyne on 10/9/24.
//

import SwiftUI

struct Project: Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var link: String
}

struct PortfolioView: View {
    let projects = [
        Project(name: "Project One", description: "Task App", link: "https://github.com/TaskApp"),
        Project(name: "Project Two", description: "Weather App", link: "https://github.com/WeatherApp")
    ]
    
    var body: some View {
        List(projects) { project in
            VStack(alignment: .leading) {
                Text(project.name)
                    .font(.headline)
                Text(project.description)
                    .font(.subheadline)
                Button(action: {
                    if let url = URL(string: project.link) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("View on GitHub")
                        .foregroundColor(.blue)
                }
            }
        }
        .navigationBarTitle("Portfolio")
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}
