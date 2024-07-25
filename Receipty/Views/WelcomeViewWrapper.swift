//
//  WelcomeViewWrapper.swift
//  Receipty
//
//  Created by Muhammad Anas on 25/07/2024.
//



import SwiftUI

struct WelcomeViewWrapper: View {
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore: Bool = false

    var body: some View {
        Group {
            if hasLaunchedBefore {
                HomeView()
            } else {
                WelcomeView(hasLaunchedBefore: $hasLaunchedBefore)
                    .onAppear {
                        UserDefaultsHelper.shared.initializeDefaultReceipts()
                    }
            }
        }
    }
}
