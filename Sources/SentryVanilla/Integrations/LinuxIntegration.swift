#if os(Linux)
  import Glibc

  internal struct LinuxIntegration: SentryIntegration {
    public func register(hub: Hub, options _: SentryOptions) {
      hub.configure(scope: { s in s.tags["os"] = "Linux" })
    }
  }

#endif
