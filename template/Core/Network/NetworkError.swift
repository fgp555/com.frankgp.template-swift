import Foundation

/// Network errors handled by APIClient.
enum NetworkError: LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case httpError(statusCode: Int, data: Data?)
    case decodingError(Error)
    case unauthorized
    case noData
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "La URL proporcionada no es válida."
        case .requestFailed(let error):
            return "Error en la petición: \(error.localizedDescription)"
        case .invalidResponse:
            return "La respuesta del servidor no es válida."
        case .httpError(let statusCode, _):
            return "Error de servidor con código \(statusCode)."
        case .decodingError(let error):
            return "Error al procesar la respuesta: \(error.localizedDescription)"
        case .unauthorized:
            return "Sesión expirada o no autorizada. Por favor, inicia sesión nuevamente."
        case .noData:
            return "El servidor no devolvió datos."
        case .unknown:
            return "Ocurrió un error desconocido."
        }
    }
}
