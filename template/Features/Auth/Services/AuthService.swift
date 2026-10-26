import Foundation

enum AuthEndpoint: Endpoint {
    case login(email: String, password: String)
    case register(name: String, email: String, password: String)
    case fetchProfile

    var path: String {
        switch self {
        case .login: return "/auth/login"
        case .register: return "/auth/register"
        case .fetchProfile: return "/auth/me"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .login, .register: return .post
        case .fetchProfile: return .get
        }
    }

    var body: Data? {
        switch self {
        case .login(let email, let password):
            let payload = ["email": email, "password": password]
            return try? JSONSerialization.data(withJSONObject: payload)
        case .register(let name, let email, let password):
            let payload = ["name": name, "email": email, "password": password]
            return try? JSONSerialization.data(withJSONObject: payload)
        case .fetchProfile:
            return nil
        }
    }
}

protocol AuthServiceProtocol {
    func login(email: String, password: String) async throws -> (User, String)
}

final class AuthService: AuthServiceProtocol {
    private let client: APIClientProtocol

    init(client: APIClientProtocol = APIClient.shared) {
        self.client = client
    }

    func login(email: String, password: String) async throws -> (User, String) {
        // Simulación o llamada a API real
        // Para pruebas sin servidor, retornamos un usuario mock si las credenciales coinciden
        if email == "demo@template.com" && password == "123456" {
            try await Task.sleep(nanoseconds: 1_000_000_000) // 1 seg delay
            return (User.mock, "mock_jwt_token_xyz_123")
        }

        // Si hay backend configurado:
        // let response: LoginResponse = try await client.request(AuthEndpoint.login(email: email, password: password))
        // return (response.user, response.token)

        throw NetworkError.unauthorized
    }
}

struct LoginResponse: Codable {
    let user: User
    let token: String
}
