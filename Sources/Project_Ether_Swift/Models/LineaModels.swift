import Foundation
// MARK: - The Alchemist's Models

/// The standard envelope for any JSON-RPC response.
/// Using a Generic <T> allows us to reuse this for Blocks, Balances, or Transactions.

struct LineaResponse<T: Decodable>: Decodable {
    let jsonrpc: String
    let id: Int
    let result: T
}

/// A detailed model for Block information.

struct BlockResult: Decodable {
    let number: String
    let hash: String
    let miner: String

    /// Computed Property: Converts Hex string to a human-readable Integer.
    /// Java equivalent: A getter method that performs the radix conversion.
    var blockNumber: Int {
        return Int(number.dropFirst(2), radix: 16) ?? 0
    }
}