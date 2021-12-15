import Foundation

import class SentryVanilla.Scope

typealias SentryVanillaScope = SentryVanilla.Scope

extension Scope {
  func configure(_ scope: inout SentryVanillaScope) {
    scope.tags = tags
  }
}

extension SentryVanillaScope: ConfigurableScope {
  public func setTag(value: String, key: String) {
    self.tags[key] = value
  }
}
