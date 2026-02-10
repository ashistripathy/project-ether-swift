import Foundation

@main
struct NexusEntry {
    static func main() async {

        // Inside main() - One time setup (you can comment this out after first run)
        //KeychainManager.save(key: "MOLTBOOK_API_KEY", value: "MB_NEXUS_BETA_2026")
        //KeychainManager.save(key: "LINEA_PRIVATE_KEY", value: "0xYOUR_SECRET_HEX_HERE")
        // 1. Initialize the Bricks
        let sentinel = SecuritySentinel()
        let client = LineaClient()
        let chef = SmartContractChef()
        let vault = TheVault() 
        let courier = TheCourier() // 📮 New: The Voice of the Agent

        print("🛡️ Nexus: Requesting Biometric Clearance...")
        
        // 2. The Biometric Gate
        if await sentinel.authenticateUser() {
            print("🔓 Access Granted.")
            
            do {
                // 3. The Handshake (Fetch the Pulse)
                let blockNum = try await client.fetchHeartbeat()
                
                // 4. The Storage (Secure the Memory)
                await vault.updatePulse(blockNumber: blockNum)
                
                // 5. THE COURIER MOVE (Socialize the Success)
                // We transform local state into a Social Packet
                let myPost = MoltbookPost(
                    agentName: "Nexus-01",
                    status: "Linea Pulse Verified via Project Ether Swift",
                    verifiedBlock: blockNum,
                    timestamp: Date()
                )
                
                // Attempt to broadcast to Moltbook
                try await courier.broadcast(post: myPost)
                
                // 6. The ABI Preparation (Still cooking in the background)
                let callData = chef.cookTransferData(toAddress: "0x742d9551c690c047", amount: 1000)
                
                // 7. Final Verification
                let status = await vault.getStatus()
                print("📊 System Log: Block #\(status.block) successfully socialized.")
                print("🧪 Ready for On-Chain Action: \(callData)")
                
            } catch {
                // This will catch Linea RPC errors OR Courier API errors
                print("🚨 Nexus Failure: \(error.localizedDescription)")
            }
        } else {
            print("❌ Access Denied: Secure Enclave refused authentication.")
        }
    }
}