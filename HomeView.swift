//
//  HomeView.swift
//  ResumePortfolio
//
//  Created by Eric Cheyne on 10/9/24.
//

// HomeView.swift

import SwiftUI

struct HomeView: View {
    @State private var isVisible = false // State to control the animation

    var body: some View {
        VStack {
            Image("profileImage")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .shadow(radius: 10)
                .opacity(isVisible ? 1 : 0) // Apply opacity animation
                .animation(.easeIn(duration: 1.0), value: isVisible) // Fade in with a 1-second duration

            Text("Hello, I'm Eric Cheyne")
                .font(.title)
                .padding()
                .opacity(isVisible ? 1 : 0)
                .animation(.easeIn(duration: 1.0).delay(0.5), value: isVisible) // Add delay to stagger the text animation

            Text("iOS Developer | Designer | Data Analyst")
                .font(.subheadline)
                .padding(.bottom, 20)
                .opacity(isVisible ? 1 : 0)
                .animation(.easeIn(duration: 1.0).delay(1.0), value: isVisible) // Delay further for subtext

            Button(action: {
                // Action for the button
            }) {
                Text("View Resume")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .opacity(isVisible ? 1 : 0)
            .animation(.easeIn(duration: 1.0).delay(1.5), value: isVisible)
        }
        .padding()
        .onAppear {
            isVisible = true // Trigger the animation when the view appears
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
