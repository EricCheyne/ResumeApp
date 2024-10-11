//
//  HomeView.swift
//  ResumePortfolio
//
//  Created by Eric Cheyne on 10/9/24.
//

// HomeView.swift

import SwiftUI

struct HomeView: View {
    @State private var isVisible = false // Controls visibility for animations
    @State private var isVisibleText = false
    @State private var isProfileExpanded = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Gradient background for a polished look
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.purple.opacity(0.5)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)

                VStack {
                    // Profile Image with bounce and glow effect
                    ZStack {
                        Circle()
                            .stroke(Color.purple, lineWidth: 4)
                            .scaleEffect(isVisible ? 1.1 : 0.9)
                            .opacity(isVisible ? 0.5 : 0)
                            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isVisible)

                        Image("profileImage")
                            .resizable()
                            .scaledToFit()
                            .frame(width: isProfileExpanded ? 200 : geometry.size.width * 0.4)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                            .scaleEffect(isVisible ? 1 : 0.8)
                            .opacity(isVisible ? 1 : 0)
                            .animation(.spring(response: 0.5, dampingFraction: 0.6), value: isVisible)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    isProfileExpanded.toggle()
                                }
                            }
                    }
                    .padding(.bottom, 20)

                    // Name Text with fade and slide-in transition
                    Text("Hello, I'm Eric Cheyne")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.primary)
                        .padding(.bottom, 8)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                        .opacity(isVisibleText ? 1 : 0)
                        .animation(.easeIn(duration: 1.0).delay(0.5), value: isVisibleText)

                    // Subheading Text with subtle delay for smooth staggered effect
                    Text("iOS Developer | Web Developer | Data Science")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 40)
                        .opacity(isVisibleText ? 1 : 0)
                        .animation(.easeIn(duration: 1.0).delay(1.0), value: isVisibleText)

                    // Button with gradient background, scale effect, and tap interaction
                    Button(action: {
                        // Resume action
                    }) {
                        HStack {
                            Image(systemName: "arrow.down.doc.fill")
                            Text("View Resume")
                                .fontWeight(.semibold)
                        }
                        .padding()
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .scaleEffect(isVisible ? 1 : 0.95)
                        .animation(.easeIn(duration: 1.0).delay(1.5), value: isVisible)
                    }
                    .buttonStyle(PlainButtonStyle()) // Ensures consistent look across platforms
                }
                .padding()
                .onAppear {
                    withAnimation {
                        isVisible = true
                        isVisibleText = true
                    }
                }
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
