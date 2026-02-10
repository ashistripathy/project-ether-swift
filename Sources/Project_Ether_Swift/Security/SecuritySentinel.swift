import Foundation
import LocalAuthentication
struct SecuritySentinel {
    /// Challenges the user with Biometrics or Password
    func authenticateUser() async -> Bool {
        let context = LAContext()
        var error: NSError?

        // Check if the device is even capable of authentication
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            print("🔍 Sentinel: Hardware is ready. Attempting prompt...")
            let reason = "Authorize 'Project Ether Swift' to access the Linea Heartbeat."
            
            do {
                // The actual hardware challenge
                let success = try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason)
                return success
            } catch {
                print("🚨 Sentinel: Authentication error - \(error.localizedDescription)")
                return false
            }
        } else {
            print("⚠️ Sentinel: Biometrics/Password not configured on this Mac.")
            return false
        }
    }
}