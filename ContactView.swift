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
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        
        Form {
            Section(header: Text("Contact Me")) {
                TextField("Name", text: $name)
                    .autocapitalization(.words)
                    .disableAutocorrection(true)
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                TextEditor(text: $message)
                    .frame(height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            
            Button(action: {
                // Validate and send the message
                handleSendMessage()
            }) {
                Text("Send Message")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .navigationBarTitle("Contact")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Message Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    // Handle the form submission
    func handleSendMessage() {
        if name.isEmpty || email.isEmpty || message.isEmpty {
            alertMessage = "All fields are required."
            showAlert = true
            return
        }
        
        if !isValidEmail(email) {
            alertMessage = "Please enter a valid email address."
            showAlert = true
            return
        }
        
        // Simulate message sending (e.g., print to console or send an email)
        print("Name: \(name)")
        print("Email: \(email)")
        print("Message: \(message)")
        
        // Show success alert
        alertMessage = "Your message has been sent!"
        showAlert = true
        
        // Optionally, reset the form
        resetForm()
    }
    
    // Validate email format
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    // Reset the form fields after submission
    func resetForm() {
        name = ""
        email = ""
        message = ""
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}

