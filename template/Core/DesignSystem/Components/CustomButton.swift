import SwiftUI

enum ButtonStyleType {
    case primary
    case secondary
    case outline
}

struct CustomButton: View {
    let title: String
    var iconName: String? = nil
    var style: ButtonStyleType = .primary
    var isLoading: Bool = false
    var isDisabled: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: {
            if !isLoading && !isDisabled {
                action()
            }
        }) {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView()
                        .tint(textColor)
                } else {
                    if let iconName = iconName {
                        Image(systemName: iconName)
                            .font(.headline)
                    }
                    Text(title)
                        .font(.headline)
                        .fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 20)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: style == .outline ? 1.5 : 0)
            )
        }
        .disabled(isDisabled || isLoading)
        .opacity(isDisabled ? 0.6 : 1.0)
    }

    private var backgroundColor: Color {
        switch style {
        case .primary: return AppColors.primary
        case .secondary: return AppColors.secondaryBackground
        case .outline: return Color.clear
        }
    }

    private var textColor: Color {
        switch style {
        case .primary: return .white
        case .secondary: return AppColors.primary
        case .outline: return AppColors.primary
        }
    }

    private var borderColor: Color {
        style == .outline ? AppColors.primary : .clear
    }
}

#Preview {
    VStack(spacing: 16) {
        CustomButton(title: "Iniciar Sesión", iconName: "arrow.right", style: .primary, action: {})
        CustomButton(title: "Cargando...", style: .primary, isLoading: true, action: {})
        CustomButton(title: "Secundario", style: .secondary, action: {})
        CustomButton(title: "Borde", style: .outline, action: {})
    }
    .padding()
}
