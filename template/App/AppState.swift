import SwiftUI
import Combine

/// Centralized state manager for authentication and global user session.
final class AppState: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User? = nil
    @Published var isLoadingSession: Bool = true

    init() {
        checkStoredSession()
    }

    func checkStoredSession() {
        isLoadingSession = true
        if let token = KeychainManager.shared.getToken(), !token.isEmpty {
            // Restore user session
            self.isAuthenticated = true
            self.currentUser = User.mock
        } else {
            self.isAuthenticated = false
            self.currentUser = nil
        }
        isLoadingSession = false
    }

    func login(user: User, token: String) {
        KeychainManager.shared.saveToken(token)
        self.currentUser = user
        self.isAuthenticated = true
    }

    func logout() {
        KeychainManager.shared.deleteToken()
        self.currentUser = nil
        self.isAuthenticated = false
    }
}
