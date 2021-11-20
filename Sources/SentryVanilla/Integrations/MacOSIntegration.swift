#if os(macOS)
  import Cocoa
  import Darwin

  internal struct MacOSIntegration: SentryIntegration {
    public func register(hub: Hub, options _: SentryOptions) {
      hub.configure(scope: { s in s.tags["os"] = "macOS" })
    }
  }

#endif
