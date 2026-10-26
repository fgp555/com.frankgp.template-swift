//
//  templateApp.swift
//  template
//
//  Created by m1 on 26/10/2026.
//

import SwiftUI

@main
struct templateApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
        }
    }
}
