import Foundation
// MARK: - The Courier's Packet
struct MoltbookPost: Codable {
    let agentName: String
    let status: String
    let verifiedBlock: Int
    let timestamp: Date

    enum CodingKeys: String, CodingKey {
        case agentName = "agent_name"
        case status
        case verifiedBlock = "verified_block"
        case timestamp
    }
}