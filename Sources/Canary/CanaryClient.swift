import Foundation
import SentryVanilla

public struct CanaryClient {
  public init() {}

  #if canImport(Sentry) && !os(Linux)
    let sentry = SentryCocoaSDK.self
  #else
    let sentry = SentryVanillaSDK.self
  #endif

  public func start(withOptions options: CanaryOptions) throws {
    #if canImport(Sentry) && !os(Linux)
      sentry.start { newOptions in
        newOptions.dsn = options.dsn
      }
    #else
      try sentry.start { newOptions in
        newOptions.dsn = options.dsn
      }
    #endif
  }

  public func configureScope(_ callback: @escaping (ConfigurableScope) -> Void) {
    #if canImport(Sentry) && !os(Linux)
      sentry.configureScope(callback)
    #else
      sentry.configure { scope in
        callback(scope)
      }
    #endif
  }

  public func captureError(_ error: Error, configureScope: @escaping (ConfigurableScope) -> Void) {
    #if canImport(Sentry) && !os(Linux)
      sentry.capture(error: error, block: configureScope)
    #else
      sentry.capture(event: .init(error: error)) { scope in
        configureScope(scope)
      }
    #endif
  }

  public func captureEvent(_ event: CanaryEvent, configureScope: @escaping (ConfigurableScope) -> Void) {
    #if canImport(Sentry) && !os(Linux)
      sentry.capture(event: SentryCocoaEvent(event: event), block: configureScope)
    #else

      sentry.capture(event: SentryVanillaEvent(event: event)) { scope in
        configureScope(scope)
      }
    #endif
  }
}
