import Foundation
import SentryVanilla

public protocol ConfigurableScope {
  func setTag(value: String, key: String)
}
