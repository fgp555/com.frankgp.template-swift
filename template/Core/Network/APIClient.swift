import Foundation

/// Protocol for the API Client to enable mocking in tests.
protocol APIClientProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

/// Generic async/await URLSession API Client with automatic token injection.
final class APIClient: APIClientProtocol {
    static let shared = APIClient()

    private let session: URLSession
    private let baseURL: String

    init(session: URLSession = .shared, baseURL: String = AppConfig.baseURL) {
        self.session = session
        self.baseURL = baseURL
    }

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        var request = try endpoint.urlRequest(baseURLString: baseURL)

        // Inject auth token if present
        if let token = KeychainManager.shared.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await session.data(for: request)
        } catch {
            throw NetworkError.requestFailed(error)
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200...299:
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError(error)
            }
        case 401:
            KeychainManager.shared.deleteToken()
            throw NetworkError.unauthorized
        default:
            throw NetworkError.httpError(statusCode: httpResponse.statusCode, data: data)
        }
    }
}
