public enum CanaryLevel {
  /// Appropriate for messages that contain information normally of use only when
  /// tracing the execution of a program.
  case trace

  /// Appropriate for messages that contain information normally of use only when
  /// debugging a program.
  case debug

  /// Appropriate for informational messages.
  case info

  /// Appropriate for conditions that are not error conditions, but that may require
  /// special handling.
  case notice

  /// Appropriate for messages that are not error conditions, but more severe than
  /// `.notice`.
  case warning

  /// Appropriate for error conditions.
  case error

  /// Appropriate for critical error conditions that usually require immediate
  /// attention.
  ///
  /// When a `critical` message is logged, the logging backend (`LogHandler`) is free to perform
  /// more heavy-weight operations to capture system state (such as capturing stack traces) to facilitate
  /// debugging.
  case critical
}

//
// public extension CanaryLevel {
//  init(level: Logger.Level) {
//    switch level {
//    case .trace:
//      self = .trace
//
//    case .debug:
//      self = .debug
//
//    case .info:
//      self = .info
//
//    case .notice:
//      self = .notice
//
//    case .warning:
//      self = .warning
//
//    case .error:
//      self = .error
//
//    case .critical:
//      self = .critical
//    }
//  }
// }

#if canImport(Sentry) && !os(Linux)
  import class Sentry.Event
  import class Sentry.Scope
  import enum Sentry.SentryLevel
  import class Sentry.SentrySDK

  typealias SentryCocoaScope = Sentry.Scope
  typealias SentryCocoaSDK = Sentry.SentrySDK
  typealias SentryCocoaEvent = Sentry.Event
  typealias SentryCocoaLevel = Sentry.SentryLevel

  extension SentryCocoaScope: ConfigurableScope {
    convenience init(scope: Scope) {
      self.init()
      self.setTags(scope.tags)
    }
  }

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

  extension SentryCocoaEvent {
    convenience init(event: CanaryEvent) {
      self.init()
      self.level = .init(level: event.level)
      self.logger = event.logger
      self.error = event.error
//    self.breadcrumbs
//    self.context
//    self.debugMeta
//    self.dist
      self.environment = event.environment
//    self.exceptions
//    self.fingerprint
      self.message = .init(formatted: event.message)
//    self.modules
//    self.releaseName
//    self.startTimestamp
//    self.serverName
//    self.threads
//    self.user
      self.tags = event.tags
//    self.timestamp
      self.type = event.type
    }
  }
#endif
