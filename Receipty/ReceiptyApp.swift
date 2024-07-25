//
//  ReceiptyApp.swift
//  Receipty
//
//  Created by Muhammad Anas on 14/07/2024.

//
//  ReceiptyApp.swift
//  Receipty
//
//  Created by Muhammad Anas on 14/07/2024.
//

import SwiftUI

@main
struct ReceiptyApp: App {
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore: Bool = false

    var body: some Scene {
        WindowGroup {
            if hasLaunchedBefore {
                HomeView()
            } else {
                WelcomeViewWrapper()
            }
        }
    }
}
