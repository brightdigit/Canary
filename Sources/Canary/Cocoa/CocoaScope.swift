#if canImport(Sentry) && !os(Linux)
  import class Sentry.Scope

  typealias SentryCocoaScope = Sentry.Scope

  extension SentryCocoaScope: ConfigurableScope {
    convenience init(scope: Scope) {
      self.init()
      self.setTags(scope.tags)
    }
  }
#endif
