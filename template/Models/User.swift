import Foundation

struct User: Identifiable, Codable, Equatable {
    let id: String
    let name: String
    let email: String
    let role: String?
    let avatarURL: String?

    static let mock = User(
        id: "usr_123",
        name: "Usuario Demostración",
        email: "demo@template.com",
        role: "Administrador",
        avatarURL: nil
    )
}
