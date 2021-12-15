import Foundation
import SentryVanilla

public protocol CanaryEvent {
  var level: CanaryLevel { get }
  var logger: String? { get }
  var error: Error? { get }
  var environment: String? { get }
  var tags: [String: String]? { get }
  var type: String? { get }
  var message: String { get }
}
