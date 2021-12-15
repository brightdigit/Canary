#if canImport(Sentry) && !os(Linux)
  import class Sentry.SentrySDK

  typealias SentryCocoaSDK = Sentry.SentrySDK

#endif
