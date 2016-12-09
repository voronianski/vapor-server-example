import PackageDescription

let package = Package(
  name: "App",
  dependencies: [
    .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 1),
    .Package(url: "https://github.com/vapor/mongo-provider.git", majorVersion: 1, minor: 1)
  ]
)
