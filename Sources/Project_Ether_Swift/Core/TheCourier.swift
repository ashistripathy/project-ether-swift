import Foundation

struct TheCourier {
    private let endpoint = URL(string: "https://webhook.site/d45952fe-6f23-4108-b7bc-6b8b47d821bc")!
    private let apiKey = "MB_NEXUS_BETA_2026" // 🛡️ Placeholder for Phase 2

    func broadcast(post: MoltbookPost) async throws {
        print("📮 Courier: Preparing transmission to Moltbook...")

        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Encode the Struct into JSON Data
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601 // Professional standard for timestamps
        request.httpBody = try encoder.encode(post)

        // Execute transmission
        // 1. Keep 'data'
        let (data, response) = try await URLSession.shared.data(for: request)

        // 2. Use 'data' to print the server's reply if things go wrong
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            let serverMessage = String(data: data, encoding: .utf8) ?? "No error message"
            print("🚨 Courier: Server rejected post. Message: \(serverMessage)")
            throw NSError(domain: "CourierError", code: httpResponse.statusCode)
        }

        print("✅ Courier: Post successfully broadcasted to Moltbook Social Layer.")
    }
}