import SwiftUI

struct ContentView: View {
    @StateObject private var appState = AppState()

    var body: some View {
        RootView()
            .environmentObject(appState)
    }
}

#Preview {
    ContentView()
}
