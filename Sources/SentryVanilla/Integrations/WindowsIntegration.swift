#if os(Windows)
  import Win32

  internal struct WindowsIntegration: SentryIntegration {
    public func register(hub: Hub, options _: SentryOptions) {
      hub.configure(scope: { s in s.tags["os"] = "Windows" })
    }
  }

#endif
