//
//  ResumeView.swift
//  ResumePortfolio
//
//  Created by Eric Cheyne on 10/9/24.
//

import SwiftUI

struct ResumeView: View {
    var body: some View {
        List {
            Section(header: Text("Education")) {
                Text("M.S. in Computer Science")
                Text("California State University, Fullerton")
            }
            
            Section(header: Text("Experience")) {
                Text("Software Engineer at Apple Inc.")
                Text("iOS Developer Intern at Apple Inc.")
            }
            
            Section(header: Text("Skills")) {
                Text("Swift, SwiftUI, Python, AWS")
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Resume")
    }
}

struct ResumeView_Previews: PreviewProvider {
    static var previews: some View {
        ResumeView()
    }
}
