#if canImport(Sentry) && !os(Linux)
  import enum Sentry.SentryLevel

  typealias SentryCocoaLevel = Sentry.SentryLevel

  public extension SentryCocoaLevel {
    init(level: CanaryLevel) {
      switch level {
      case .trace:
        self = .debug

      case .debug:
        self = .debug

      case .info:
        self = .info

      case .notice:
        self = .info

      case .warning:
        self = .warning

      case .error:
        self = .error

      case .critical:
        self = .fatal
      }
    }
  }
#endif
