import Foundation
import SentryVanilla

public struct CanaryOptions {
  public init(dsn: String) {
    self.dsn = dsn
  }

  let dsn: String
}
