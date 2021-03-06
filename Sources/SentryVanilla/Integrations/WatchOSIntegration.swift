#if os(watchOS)
  import UIKit

  internal struct WatchOSIntegration: SentryIntegration {
    public func register(hub: Hub, options _: SentryOptions) {
      hub.configure(scope: { s in s.tags["os"] = "watchOS" })
    }
  }

#endif
