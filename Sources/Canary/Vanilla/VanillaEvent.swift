import Foundation

import struct SentryVanilla.SentryEvent

typealias SentryVanillaEvent = SentryVanilla.SentryEvent

extension SentryVanillaEvent {
  init(event: any CanaryEvent) {
    var tags = event.tags ?? [String: String]()
    tags["logger"] = event.logger
    self.init(message: event.message, tags: tags)
  }

  init(error: Error) {
    self.init(message: error.localizedDescription)
  }
}
