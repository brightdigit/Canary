#if os(iOS)
  import UIKit

  internal struct IOSIntegration: SentryIntegration {
    public func register(hub: Hub, options _: SentryOptions) {
      hub.configure(scope: { s in s.tags["os"] = "iOS" })
    }
  }

#endif
