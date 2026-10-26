import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        Group {
            if appState.isLoadingSession {
                LoadingOverlay(message: "Cargando sesión...")
            } else if appState.isAuthenticated {
                MainTabView()
            } else {
                LoginView()
            }
        }
        .animation(.default, value: appState.isAuthenticated)
    }
}

#Preview {
    RootView()
        .environmentObject(AppState())
}
