import Foundation

public struct SentryEvent {
  public init(message: String? = nil, tags: [String: String]? = nil) {
    self.message = message
    self.tags = tags
  }

  public let id = UUID()
  public var message: String?
  public var tags: [String: String]?
}
