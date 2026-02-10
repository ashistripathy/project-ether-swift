import Foundation
struct SmartContractChef{
    /// Prepares a 'transfer' call: transfer(address,uint256)
    func cookTransferData(toAddress: String,amount: UInt64)->String{
        let selector = "a9059cbb"
        let cleanAddress = toAddress.replacingOccurrences(of: "0x", with: "").lowercased()
        let paddedAddress = cleanAddress.paddingLeft(toLength: 64, withPad: "0")

        let hexAmount = String(amount, radix: 16)
        let paddedAmount = hexAmount.paddingLeft(toLength: 64, withPad: "0")

        return "0x" + selector + paddedAddress + paddedAmount
    }
}
// MARK: - Utility Extension for Zero-Waste Padding
extension String {
    func paddingLeft(toLength: Int, withPad: String) -> String {
        let paddingCount = toLength - self.count
        guard paddingCount > 0 else { return self }
        let padding = String(repeating: withPad, count: paddingCount)
        return padding + self
    }
}