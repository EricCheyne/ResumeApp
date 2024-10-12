//
//  HomeView.swift
//  ResumePortfolio
//
//  Created by Eric Cheyne on 10/9/24.
//

import SwiftUI
import PDFKit

struct HomeView: View {
    @State private var isVisible = false
    @State private var showResume = false // State to control full-screen PDF presentation

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // System background color (adapts to dark and light mode)
                Color(uiColor: .systemBackground)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Image("profileImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.4)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .scaleEffect(isVisible ? 1 : 0.8) // Slight scaling for a bounce effect
                        .opacity(isVisible ? 1 : 0)
                        .animation(
                            Animation.timingCurve(0.5, 0.1, 0.8, 1.0, duration: 1.0), // Custom easing curve
                            value: isVisible
                        )
                    
                    Text("Hello, I'm Eric Cheyne")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Color(uiColor: .label)) // Adaptive text color for dark/light mode
                        .padding(.bottom, 8)
                        .transition(.move(edge: .leading).combined(with: .opacity)) // Slide-in from left + fade
                        .opacity(isVisible ? 1 : 0)
                        .animation(.easeIn(duration: 1.0).delay(0.5), value: isVisible)

                    Text("iOS Developer | Web Developer | Data Science")
                        .font(.subheadline)
                        .foregroundColor(Color(uiColor: .secondaryLabel)) // Adaptive color
                        .padding(.bottom, 40)
                        .opacity(isVisible ? 1 : 0)
                        .animation(.easeIn(duration: 1.0).delay(1.0), value: isVisible)

                    Button(action: {
                        // Show the PDF resume in full screen
                        showResume = true
                    }) {
                        HStack {
                            Image(systemName: "arrow.down.doc.fill")
                            Text("View Resume")
                        }
                        .padding()
                        .background(LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.purple]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .rotationEffect(isVisible ? .degrees(0) : .degrees(-90)) // Button rotates into view
                        .shadow(radius: 5)
                    }
                    .scaleEffect(isVisible ? 1 : 0.95)
                    .opacity(isVisible ? 1 : 0)
                    .animation(.easeIn(duration: 1.0).delay(1.5), value: isVisible)
                }
                .padding()
                .onAppear {
                    isVisible = true
                }
                .fullScreenCover(isPresented: $showResume) {
                    PDFViewer()
                } // Present the PDFViewer in full screen
            }
        }
    }
}

// PDFViewer to display the PDF file in full screen
struct PDFViewer: View {
    @Environment(\.presentationMode) var presentationMode // To dismiss the view
    
    var body: some View {
        NavigationView {
            PDFKitView(fileName: "resume") // Name of the PDF file
                .edgesIgnoringSafeArea(.all) // Ensure the PDF view uses the full screen
                .navigationBarItems(trailing: Button("Done") {
                    presentationMode.wrappedValue.dismiss() // Dismiss the PDF view
                })
                .navigationBarTitle("Resume", displayMode: .inline) // Add a title to the navigation bar
        }
    }
}

// PDFKitView to render the PDF using PDFKit
struct PDFKitView: UIViewRepresentable {
    let fileName: String

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()

        if let url = Bundle.main.url(forResource: fileName, withExtension: "pdf") {
            if let document = PDFDocument(url: url) {
                pdfView.document = document
            }
        }

        pdfView.autoScales = true // Auto-scale to fit the screen
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // No updates needed for now
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
