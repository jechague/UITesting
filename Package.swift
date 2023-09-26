// swift-tools-version: 5.7
import PackageDescription

let package = Package(
	name: "GXUITest",
	platforms: [.iOS("12.0"), .macOS("13.0")],
	products: [
		.library(
			name: "GXUITest",
			targets: ["GXUITest"]),
		.plugin(name: "ExecuteTests", targets: ["ExecuteTests"])
	],
	dependencies: [
		.package(url: "https://github.com/GeneXus-SwiftPackages/GXStandardClasses.git", .upToNextMajor(from: "1.1.0-beta")),
		.package(url: "https://github.com/AliSoftware/OHHTTPStubs.git", from: "9.1.0"),
        .package(url: "https://github.com/jechague/GXXcodeTools.git", branch: "main")
	],
	targets: [
		.target(name: "GXUITest",
				dependencies: [
					.product(name: "GXStandardClasses", package: "GXStandardClasses"),
				]
		),
		
		// MARK: Plugin targets
		
		.plugin(name: "ExecuteTests",
				capability: .command(intent: .custom(verb: "run-tests", description: "Run and extract results from GX Tests in project")),
			   dependencies: [
				.product(name: "RunTests", package: "GXXcodeTools"),
				.product(name: "ExtractTestResults", package: "GXXcodeTools")
			   ]),

		.testTarget(name: "GXUITestUnitTests",
				   dependencies: [
					"GXUITest",
					.product(name: "OHHTTPStubsSwift", package: "ohhttpstubs")
				   ],
					resources: [
						.copy("SampleImages.xcassets")
					]
		)
	]
)
