import Foundation

// MARK: - Level 4: Manifesto (Zero-Waste & Async)
struct LineaClient {
    let rpcURL = URL(string: "https://rpc.linea.build")!

    func fetchHeartbeat() async throws -> Int {
        print("⚡️ Nexus: Initiating Handshake with Linea L2...")

        /* The Data Model (The "Payload")
        What it is: A standard Swift Dictionary.

Java Reference: Think of this as a HashMap<String, Object>.

The Nexus Logic: Ethereum nodes communicate via JSON-RPC.
 This payload is the universal language of the blockchain. We are asking Linea, 
 "What is the most recent block number you've sealed?" */

        let payload: [String: Any] = [
            "jsonrpc": "2.0",
            "id": 1,
            "method": "eth_blockNumber",
            "params": []
        ]
/* The Network Request (URLRequest)
The Action: We transform our Dictionary into a Data Buffer (Binary).

 */
        var request = URLRequest(url: rpcURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: payload)

        // NEXUS FIX: Use .data(for:) for native Swift Concurrency
        //The Modern Handshake (await)
        /* The Magic: This is the Async Manifesto. The keyword await tells the CPU: 
        "I’m going to wait for the internet to respond. Don't freeze the whole app; go do other work,
         and come back to me when the data is here."

Java Reference: Unlike a future.get() which blocks the thread, Swift "suspends" 
the function. It is incredibly efficient on MacBook hardware. */

        let (data, _) = try await URLSession.shared.data(for: request)

        let decodedResponse = try JSONDecoder().decode(LineaResponse<String>.self, from: data)

        let resultHex = decodedResponse.result
        let blockNumber = Int(resultHex.dropFirst(2), radix: 16) ?? 0

        print("✅ Linea Pulse Confirmed: Block #\(blockNumber)")
        return blockNumber
    }
}