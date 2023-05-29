#if canImport(Sentry) && !os(Linux)
  import class Sentry.Event

  typealias SentryCocoaEvent = Sentry.Event

  extension SentryCocoaEvent {
    convenience init(event: any CanaryEvent) {
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
