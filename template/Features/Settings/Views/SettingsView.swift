import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationStack {
            List {
                Section("Perfil de Usuario") {
                    HStack(spacing: 16) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(AppColors.primary)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(appState.currentUser?.name ?? "Usuario")
                                .font(.headline)
                            Text(appState.currentUser?.email ?? "demo@template.com")
                                .font(.subheadline)
                                .foregroundColor(AppColors.textSecondary)
                            Text(appState.currentUser?.role ?? "Rol no especificado")
                                .font(.caption)
                                .foregroundColor(AppColors.primary)
                        }
                    }
                    .padding(.vertical, 8)
                }

                Section("Aplicación") {
                    HStack {
                        Label("Versión", systemImage: "info.circle")
                        Spacer()
                        Text("\(AppConfig.appVersion) (\(AppConfig.buildNumber))")
                            .foregroundColor(AppColors.textSecondary)
                    }
                    HStack {
                        Label("Servidor API", systemImage: "server.rack")
                        Spacer()
                        Text(AppConfig.baseURL)
                            .font(.caption)
                            .foregroundColor(AppColors.textSecondary)
                    }
                }

                Section("Sesión") {
                    Button(role: .destructive, action: {
                        appState.logout()
                    }) {
                        HStack {
                            Spacer()
                            Label("Cerrar Sesión", systemImage: "rectangle.portrait.and.arrow.right")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Ajustes")
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppState())
}
