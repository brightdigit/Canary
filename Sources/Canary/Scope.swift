import Foundation

public struct Scope {
  public init(tags: [String: String]) {
    self.tags = tags
  }

  public let tags: [String: String]
}

extension Scope {
  func configure(_ scope: inout SentryVanillaScope) {
    scope.tags = tags
  }
}
