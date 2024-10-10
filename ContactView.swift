//
//  ContactView.swift
//  ResumePortfolio
//
//  Created by Eric Cheyne on 10/9/24.
//

import SwiftUI

struct ContactView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var message: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Contact Me")) {
                TextField("Name", text: $name)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                TextEditor(text: $message)
                    .frame(height: 100)
            }
            
            Button(action: {
                // Handle the form submission
            }) {
                Text("Send Message")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .navigationBarTitle("Contact")
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
