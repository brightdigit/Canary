import XCTest
import Foundation
@testable import SentryVanilla

final class SentryTests: XCTestCase {
    func testExample() {
        XCTAssertTrue(true)
    }

    func testValidDsnParse() throws {
        let dsn = try Dsn(dsn: URL(string: "https://a@b/1")!)
        XCTAssertEqual(dsn.envelopeUrl.absoluteString, "https://b:443/api/1/envelope/")
        XCTAssertEqual(dsn.publicKey, "a")
    }

    static var allTests = [
        ("testExample", testExample),
        ("testValidDsnParse", testValidDsnParse),
    ]
}
