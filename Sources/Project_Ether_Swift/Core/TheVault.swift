import Foundation

actor TheVault {
    private var lastPulseBlock: Int = 0
    private var handshakeCount: Int = 0

    func updatePulse(blockNumber: Int) {
        self.lastPulseBlock = blockNumber 
        self.handshakeCount += 1
        print("🏛️ Vault: Pulse stored safely. Total Handshakes: \(handshakeCount)")
    }
    func getStatus() -> (block:Int, count:Int){
        return (lastPulseBlock, handshakeCount)
    }
}   