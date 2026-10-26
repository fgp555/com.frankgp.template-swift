import Foundation

/// Centralized configuration for environments and API settings.
struct AppConfig {
    static let appName = "Template App"
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    static let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"

    // Change this to your backend server URL
    static let baseURL = "https://api.example.com/v1"
}
