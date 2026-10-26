import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()

                // Logo & Header
                VStack(spacing: 12) {
                    Image(systemName: "app.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(AppColors.primary)

                    Text(AppConfig.appName)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Inicia sesión para continuar")
                        .font(.subheadline)
                        .foregroundColor(AppColors.textSecondary)
                }

                // Form
                VStack(spacing: 16) {
                    CustomTextField(
                        title: "Correo Electrónico",
                        placeholder: "demo@template.com",
                        text: $viewModel.email,
                        iconName: "envelope",
                        keyboardType: .emailAddress
                    )

                    CustomTextField(
                        title: "Contraseña",
                        placeholder: "••••••••",
                        text: $viewModel.password,
                        iconName: "lock",
                        isSecure: true
                    )

                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(AppColors.error)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(.top, 10)

                // Actions
                VStack(spacing: 12) {
                    CustomButton(
                        title: "Iniciar Sesión",
                        iconName: "arrow.right",
                        isLoading: viewModel.isLoading,
                        isDisabled: !viewModel.isFormValid
                    ) {
                        Task {
                            await viewModel.login(appState: appState)
                        }
                    }

                    Button("¿Olvidaste tu contraseña?") {
                        // Action
                    }
                    .font(.subheadline)
                    .foregroundColor(AppColors.primary)
                }

                Spacer()

                // Helper credentials message for demo
                VStack(spacing: 4) {
                    Text("Credenciales Demo:")
                        .font(.caption)
                        .fontWeight(.bold)
                    Text("demo@template.com / 123456")
                        .font(.caption)
                        .foregroundColor(AppColors.textSecondary)
                }
                .padding(.bottom, 16)
            }
            .padding(24)
            .background(AppColors.background.ignoresSafeArea())
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AppState())
}
