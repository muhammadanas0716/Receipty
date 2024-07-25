//
//  WelcomeView.swift
//  Receipty
//
//  Created by Muhammad Anas on 12/07/2024.
//


import SwiftUI

struct WelcomeView: View {
    @Binding var hasLaunchedBefore: Bool
    @State private var username: String = ""
    @State private var isLoading: Bool = false
    @State private var showContent: Bool = false
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            // App Icon
            Image("Logo")
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(20)
                .padding(.bottom, 20)
                .scaleEffect(showContent ? 1.0 : 0.5)
                .animation(.easeOut(duration: 1.0), value: showContent)

            // Heading
            Text("Welcome to Receipty")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(colorScheme == .dark ? .secondaryText : .black)
                .padding(.bottom, 10)
                .opacity(showContent ? 1 : 0)
                .animation(.easeIn(duration: 1.0).delay(0.4), value: showContent)

            // Subtitle
            Text("Your smart receipt manager")
                .font(.title3)
                .foregroundColor(colorScheme == .dark ? .secondaryText : .gray)
                .padding(.bottom, 30)
                .opacity(showContent ? 1 : 0)
                .animation(.easeIn(duration: 1.0).delay(0.5), value: showContent)

            // Feature Details
            VStack(alignment: .leading, spacing: 15) {
                FeatureRow(iconName: "doc.text.fill", featureText: "Save and organize your receipts")
                FeatureRow(iconName: "clock.fill", featureText: "Track your expenses over time")
                FeatureRow(iconName: "chart.pie.fill", featureText: "Analyze your spending habits")
            }
            .scenePadding(.bottom)
            .opacity(showContent ? 1 : 0)
            .offset(y: showContent ? 0 : 20)
            .animation(.easeIn(duration: 1.0).delay(0.6), value: showContent)

            // Username Text Field
            VStack(alignment: .leading) {
                TextField("What should we call you?", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top, 5)
            }
            .scenePadding(.bottom)
            .opacity(showContent ? 1 : 0)
            .offset(y: showContent ? 0 : 20)
            .animation(.easeIn(duration: 1.0).delay(0.7), value: showContent)

            // Continue Button
            if isLoading {
                ProgressView()
                    .transition(.opacity)
            } else {
                Button(action: {
                    if username.isEmpty {
                        username = "User"
                    }
                    UserDefaults.standard.set(username, forKey: "username")
                    withAnimation {
                        isLoading = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isLoading = false
                            hasLaunchedBefore = true
                        }
                    }
                }) {
                    HStack {
                        Text("Continue")
                            .font(.headline)
                            .padding()
                        Image(systemName: "arrow.right")
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(colorScheme == .dark ? Color.secondaryText : Color.black)
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .cornerRadius(10)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .animation(.easeInOut(duration: 2.0), value: isLoading)
                }
            }
        }
        .padding()
        .background(colorScheme == .dark ? Color.primaryBackground : Color.white)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            withAnimation {
                showContent = true
            }
        }
    }
}

struct FeatureRow: View {
    var iconName: String
    var featureText: String
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(colorScheme == .dark ? .secondaryText : .black)
                .padding(.trailing, 10)
            Text(featureText)
                .foregroundColor(colorScheme == .dark ? .secondaryText : .gray)
                .font(.body)
            Spacer()
        }
        .padding()
        .background(colorScheme == .dark ? Color.primaryBackground.opacity(0.8) : Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(hasLaunchedBefore: .constant(false))
            .preferredColorScheme(.light) // Preview in light mode
        WelcomeView(hasLaunchedBefore: .constant(false))
            .preferredColorScheme(.dark) // Preview in dark mode
    }
}
