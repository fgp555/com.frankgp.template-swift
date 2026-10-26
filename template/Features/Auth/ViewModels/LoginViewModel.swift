import SwiftUI
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }

    var isFormValid: Bool {
        !email.trimmingCharacters(in: .whitespaces).isEmpty && password.count >= 6
    }

    func login(appState: AppState) async {
        guard isFormValid else {
            errorMessage = "Por favor ingresa un correo válido y una contraseña de al menos 6 caracteres."
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let (user, token) = try await authService.login(email: email, password: password)
            appState.login(user: user, token: token)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
