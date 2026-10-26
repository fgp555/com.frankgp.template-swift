import SwiftUI

struct LoadingOverlay: View {
    let message: String

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                ProgressView()
                    .scaleEffect(1.4)
                    .tint(.white)
                Text(message)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
            }
            .padding(24)
            .background(Color(uiColor: .systemGray6).opacity(0.9))
            .cornerRadius(16)
            .shadow(radius: 10)
        }
    }
}

#Preview {
    LoadingOverlay(message: "Cargando datos...")
}
