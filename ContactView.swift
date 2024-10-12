//
//  ContactView.swift
//  ResumePortfolio
//
//  Created by Eric Cheyne on 10/9/24.
//

import SwiftUI
import MessageUI

struct ContactView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var message: String = ""
    @State private var showMailComposer: Bool = false
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
                // Validate the fields before presenting the email composer
                if validateForm() {
                    showMailComposer = true
                }
            }) {
                Text("Send Message")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .disabled(!MFMailComposeViewController.canSendMail()) // Disable button if Mail is unavailable
        }
        .sheet(isPresented: $showMailComposer) {
            MailView(isShowing: self.$showMailComposer, recipient: "eric.cheyne@gmail.com", subject: "Message from \(name)", body: message)
        }
        .navigationBarTitle("Contact")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    // Validate form fields
    func validateForm() -> Bool {
        if name.isEmpty || email.isEmpty || message.isEmpty {
            alertMessage = "All fields are required."
            showAlert = true
            return false
        }
        
        if !isValidEmail(email) {
            alertMessage = "Please enter a valid email address."
            showAlert = true
            return false
        }
        
        return true
    }
    
    // Validate email format
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}

// SwiftUI wrapper for MFMailComposeViewController
struct MailView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    var recipient: String
    var subject: String
    var body: String
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isShowing: Bool
        
        init(isShowing: Binding<Bool>) {
            _isShowing = isShowing
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true) {
                self.isShowing = false
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing)
    }
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.setToRecipients([recipient])
        mailComposeVC.setSubject(subject)
        mailComposeVC.setMessageBody(body, isHTML: false)
        mailComposeVC.mailComposeDelegate = context.coordinator
        return mailComposeVC
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
}
