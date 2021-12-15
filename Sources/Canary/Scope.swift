import Foundation

public struct Scope {
  public init(tags: [String: String]) {
    self.tags = tags
  }

  internal let tags: [String: String]
}
