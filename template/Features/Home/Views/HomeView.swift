import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Welcome Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("¡Hola, \(appState.currentUser?.name ?? "Usuario")!")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Bienvenido de nuevo")
                                .font(.subheadline)
                                .foregroundColor(AppColors.textSecondary)
                        }
                        Spacer()

                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .foregroundColor(AppColors.primary)
                    }
                    .padding()
                    .background(AppColors.secondaryBackground)
                    .cornerRadius(16)

                    // Dashboard Cards
                    Text("Resumen General")
                        .font(.headline)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        DashboardMetricCard(title: "Proyectos", value: "12", icon: "folder.fill", color: .blue)
                        DashboardMetricCard(title: "Tareas", value: "48", icon: "checkmark.square.fill", color: .green)
                        DashboardMetricCard(title: "Notificaciones", value: "5", icon: "bell.fill", color: .orange)
                        DashboardMetricCard(title: "Rendimiento", value: "98%", icon: "bolt.fill", color: .purple)
                    }

                    // Activity Section
                    Text("Actividad Reciente")
                        .font(.headline)
                        .padding(.top, 10)

                    VStack(spacing: 12) {
                        ActivityRow(title: "Sesión iniciada correctamente", time: "Hace 2 minutos", icon: "checkmark.circle.fill", color: .green)
                        ActivityRow(title: "Plantilla cargada", time: "Hace 10 minutos", icon: "doc.fill", color: .blue)
                        ActivityRow(title: "Sistema sincronizado", time: "Hace 1 hora", icon: "arrow.triangle.2.circlepath", color: .purple)
                    }
                }
                .padding()
            }
            .navigationTitle("Dashboard")
        }
    }
}

struct DashboardMetricCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(color)
                Spacer()
            }
            Text(value)
                .font(.title)
                .fontWeight(.bold)
            Text(title)
                .font(.caption)
                .foregroundColor(AppColors.textSecondary)
        }
        .padding()
        .background(AppColors.secondaryBackground)
        .cornerRadius(14)
    }
}

struct ActivityRow: View {
    let title: String
    let time: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(time)
                    .font(.caption)
                    .foregroundColor(AppColors.textSecondary)
            }
            Spacer()
        }
        .padding()
        .background(AppColors.secondaryBackground)
        .cornerRadius(12)
    }
}

#Preview {
    HomeView()
        .environmentObject(AppState())
}
