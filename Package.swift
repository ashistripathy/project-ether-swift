// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Project_Ether_Swift",
    // 🛡️ NEXUS ADDITION: Force the compiler to target macOS 12+ 
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(name: "Project_Ether_Swift", targets: ["Project_Ether_Swift"]),
    ],
    targets: [
        .executableTarget(
            name: "Project_Ether_Swift",
            dependencies: []),
    ]
)