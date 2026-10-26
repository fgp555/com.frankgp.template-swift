import SwiftUI

struct CustomTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var iconName: String? = nil
    var isSecure: Bool = false
    var errorMessage: String? = nil
    var keyboardType: UIKeyboardType = .default

    @State private var isPasswordVisible: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(AppColors.textSecondary)

            HStack(spacing: 10) {
                if let iconName = iconName {
                    Image(systemName: iconName)
                        .foregroundColor(AppColors.textSecondary)
                }

                if isSecure && !isPasswordVisible {
                    SecureField(placeholder, text: $text)
                        .keyboardType(keyboardType)
                        .autocapitalization(.none)
                } else {
                    TextField(placeholder, text: $text)
                        .keyboardType(keyboardType)
                        .autocapitalization(.none)
                }

                if isSecure {
                    Button(action: { isPasswordVisible.toggle() }) {
                        Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(AppColors.textSecondary)
                    }
                } else if !text.isEmpty {
                    Button(action: { text = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(AppColors.textSecondary)
                    }
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(AppColors.secondaryBackground)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(errorMessage != nil ? AppColors.error : AppColors.border, lineWidth: 1)
            )

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(AppColors.error)
            }
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        CustomTextField(title: "Correo Electrónico", placeholder: "ejemplo@correo.com", text: .constant(""), iconName: "envelope", keyboardType: .emailAddress)
        CustomTextField(title: "Contraseña", placeholder: "••••••••", text: .constant("123456"), iconName: "lock", isSecure: true)
        CustomTextField(title: "Con error", placeholder: "Ingresa texto", text: .constant("Error de prueba"), errorMessage: "Campo requerido")
    }
    .padding()
}
